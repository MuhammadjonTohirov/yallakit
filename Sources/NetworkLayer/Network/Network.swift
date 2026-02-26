//
//  Network.swift
//  USDK
//
//  Created by applebro on 06/10/23.
//

import Foundation

struct Logging {
    public static func l(tag: @autoclosure () -> String = "Log", _ message: @autoclosure () -> Any) {
        #if DEBUG
        print("\(tag()): \(message())")
        #endif
    }
}


import Foundation

public protocol NetworkDelegate {
    func onAuthRequired()
    func onFailureNetwork()
}

public func setNetworkDelegate(_ delegate: NetworkDelegate?) {
    Network.delegate = delegate
}

public struct Network {

    nonisolated(unsafe) public static var delegate: NetworkDelegate?
    
    // MARK: - Error Localization Hook
    public typealias NetworkErrorLocalizer = (NetworkError) -> String
    nonisolated(unsafe) public static var errorLocalizer: NetworkErrorLocalizer?
    
    public static func setErrorLocalizer(_ localize: @escaping NetworkErrorLocalizer) {
        self.errorLocalizer = localize
    }
    
    // MARK: - Deprecated Static Methods (use NetworkClientProtocol instead)

    @available(*, deprecated, message: "Inject NetworkClientProtocol instead of using static Network methods")
    public static func send<T: NetResBody>(urlSession: URLSession = URLSession.shared, request: URLRequestProtocol) async -> NetRes<T>? {
        await DefaultNetworkClient().send(urlSession: urlSession, request: request)
    }

    @available(*, deprecated, message: "Inject NetworkClientProtocol instead of using static Network methods")
    public static func sendThrow<T: NetResBody>(urlSession: URLSession = URLSession.shared, request: URLRequestProtocol) async throws -> NetRes<T>? {
        try await DefaultNetworkClient().sendThrow(urlSession: urlSession, request: request)
    }

    @available(*, deprecated, message: "Inject NetworkClientProtocol instead of using static Network methods")
    public static func upload<T: NetResBody>(body: T.Type, request: URLRequestProtocol, completion: @escaping @Sendable (NetRes<T>?) -> Void) {
        DefaultNetworkClient().upload(body: body, request: request, completion: completion)
    }

    @available(*, deprecated, message: "Inject NetworkClientProtocol instead of using static Network methods")
    public static func upload<T: NetResBody>(body: T.Type, request: URLRequestProtocol) async throws -> NetRes<T> {
        try await DefaultNetworkClient().upload(body: body, request: request)
    }

}
