//
//  AppConfigUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 04/02/25.
//

import Foundation
import NetworkLayer
import Core

public protocol AppConfigUseCase {
    var appConfig: AppConfig? { get }
    func fetchAppConfig() async throws -> Bool
}

public final class AppConfigUseCaseImpl: AppConfigUseCase {
    @codableWrapper(key: "appConfig")
    public var appConfig: AppConfig?

    private let client: NetworkClientProtocol
    private var trial: Int = 0
    private var maxTrial: Int = 3

    public init(client: NetworkClientProtocol = DefaultNetworkClient(), maxTrial: Int = 3) {
        self.client = client
        self.maxTrial = maxTrial
    }

    public func fetchAppConfig() async throws -> Bool {
        Logging.l(tag: "AppConfigUseCase", "Fetch app config \(trial): \(trial))")
        if let result: NetRes<NetResAppConfig> = try? await client.sendThrow(request: Request()), let config = result.result {
            appConfig = .init(config)
            return true
        }
        
        if trial < maxTrial {
            trial += 1
            // sleep for 0.5 seconds
            try? await Task.sleep(for: .milliseconds(500))
            return (try? await fetchAppConfig()) ?? false
        }
        
        return false
    }
}

extension AppConfigUseCaseImpl {
    struct Request: URLRequestProtocol {
        var url: URL {
            URL.goIldamAPI.appending(path: "config")
        }
        
        var body: Data?
        
        var method: NetworkLayer.HTTPMethod { .get }
        
        func request() -> URLRequest {
            var request = URLRequest.new(url: url)
            request.httpMethod = method.rawValue
            return request
        }
    }
}
