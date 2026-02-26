//
//  NetworkClientProtocol.swift
//  NetworkLayer
//
//  Created by YallaKit on 26/02/26.
//

import Foundation

public protocol NetworkClientProtocol: Sendable {
    func send<T: NetResBody>(
        urlSession: URLSession,
        request: URLRequestProtocol
    ) async -> NetRes<T>?

    func sendThrow<T: NetResBody>(
        urlSession: URLSession,
        request: URLRequestProtocol
    ) async throws -> NetRes<T>?

    func upload<T: NetResBody>(
        body: T.Type,
        request: URLRequestProtocol,
        completion: @escaping @Sendable (NetRes<T>?) -> Void
    )

    func upload<T: NetResBody>(
        body: T.Type,
        request: URLRequestProtocol
    ) async throws -> NetRes<T>
}

public extension NetworkClientProtocol {
    func send<T: NetResBody>(
        request: URLRequestProtocol
    ) async -> NetRes<T>? {
        await send(urlSession: .shared, request: request)
    }

    func sendThrow<T: NetResBody>(
        request: URLRequestProtocol
    ) async throws -> NetRes<T>? {
        try await sendThrow(urlSession: .shared, request: request)
    }
}
