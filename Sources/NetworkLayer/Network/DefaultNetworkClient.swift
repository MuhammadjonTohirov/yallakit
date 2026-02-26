//
//  DefaultNetworkClient.swift
//  NetworkLayer
//
//  Created by YallaKit on 26/02/26.
//

import Foundation

public struct DefaultNetworkClient: NetworkClientProtocol {
    public init() {}

    public func send<T: NetResBody>(
        urlSession: URLSession = URLSession.shared,
        request: URLRequestProtocol
    ) async -> NetRes<T>? {
        do {
            return try await sendThrow(urlSession: urlSession, request: request)
        } catch {
            Logging.l(error)
            return nil
        }
    }

    public func sendThrow<T: NetResBody>(
        urlSession: URLSession = URLSession.shared,
        request: URLRequestProtocol
    ) async throws -> NetRes<T>? {
        do {
            Logging.l("--- --- REQUEST --- ---")
            Logging.l(request.url.absoluteString)

            if let requestBody = request.request().httpBody,
               let json = try JSONSerialization.jsonObject(with: requestBody, options: .fragmentsAllowed) as? [String: Any],
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]) {
                Logging.l(String(data: jsonData, encoding: .utf8) ?? "")
            }

            let result: (Data, URLResponse)

            do {
                if #available(macOS 12.0, *) {
                    result = try await urlSession.data(for: request.request())
                } else {
                    throw NetworkError.custom(message: "Data request not supported on this OS version", code: -1)
                }
            } catch let networkError as NetworkError {
                throw networkError
            } catch {
                throw NetworkError.timeout
            }

            let data = result.0

            guard let httpResponse = result.1 as? HTTPURLResponse else {
                throw NetworkError.custom(message: "Invalid response", code: -1)
            }

            let code = httpResponse.statusCode

            guard await onReceive(code: code) else {
                throw NetworkError.unauthorized
            }

            let str = try data.asJsonString()

            Logging.l("--- --- RESPONSE --- ---")
            Logging.l((request.url, code))
            Logging.l(str ?? "")

            let res = try JSONDecoder().decode(NetRes<T>.self, from: data)

            Logging.l("Parsing is successful")

            guard await onReceive(code: res.code ?? code) else {
                throw NetworkError.unauthorized
            }

            if !res.success {
                throw NetworkError.custom(message: res.error ?? res.message ?? "Unknown error", code: res.code ?? -1)
            }

            return res
        } catch {
            Logging.l(error)
            switch error as? NetworkError {
            case .custom(let message, let code):
                throw NetworkError.custom(message: message, code: code)
            default:
                throw NetworkError.custom(message: error.serverMessage, code: -1)
            }
        }
    }

    public func upload<T: NetResBody>(
        body: T.Type,
        request: URLRequestProtocol,
        completion: @escaping @Sendable (NetRes<T>?) -> Void
    ) {
        Logging.l("--- --- REQUEST --- ---")
        Logging.l(request.url.absoluteString)

        if let requestBody = request.request().httpBody,
           let json = try? JSONSerialization.jsonObject(with: requestBody, options: .fragmentsAllowed) as? [String: Any]
        {
            Logging.l(json)
        }

        URLSession.shared.uploadTask(with: request.request(), from: request.body) { data, _, error in
            guard let data = data, let res = try? JSONDecoder().decode(NetRes<T>.self, from: data) else {
                Logging.l(error?.localizedDescription ?? "Unable to parse data")
                completion(nil)
                return
            }

            Logging.l("--- --- RESPONSE --- ---")
            Logging.l(res.asString)

            completion(res)
        }.resume()
    }

    public func upload<T: NetResBody>(
        body: T.Type,
        request: URLRequestProtocol
    ) async throws -> NetRes<T> {
        Logging.l("--- --- REQUEST --- ---")
        Logging.l(request.url.absoluteString)

        var mutableRequest = request.request()
        mutableRequest.httpBody = nil

        if let requestBody = request.body,
           let json = try? JSONSerialization.jsonObject(with: requestBody, options: .fragmentsAllowed) as? [String: Any] {
            Logging.l(json)
        }

        guard let data = request.body else {
            throw NetworkError.custom(message: "No data on request", code: -1)
        }

        let resultData: Data
        if #available(macOS 12.0, *) {
            let (uploadData, _) = try await URLSession.shared.upload(for: mutableRequest, from: data)
            resultData = uploadData
        } else {
            throw NetworkError.custom(message: "Upload not supported on this OS version", code: -1)
        }

        if let json = try? JSONSerialization.jsonObject(with: resultData, options: .fragmentsAllowed) as? [String: Any] {
            Logging.l(json)
        }

        guard let res = try? JSONDecoder().decode(NetRes<T>.self, from: resultData) else {
            throw NetworkError.custom(message: "Unable to parse response", code: -1)
        }

        return res
    }

    private func onReceive(code: Int) async -> Bool {
        if code == 401 {
            Network.delegate?.onAuthRequired()
            return false
        }
        return true
    }
}
