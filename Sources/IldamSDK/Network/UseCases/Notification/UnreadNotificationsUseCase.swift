//
//  UnreadNotificationsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol UnreadNotificationsUseCaseProtocol: Sendable {
    func execute() async throws -> Int?
}

public struct UnreadNotificationsUseCase: UnreadNotificationsUseCaseProtocol, Sendable {
    private let gateway: UnreadNotificationsGatewayProtocol

    public init() {
        self.gateway = UnreadNotificationsGateway()
    }

    init(gateway: UnreadNotificationsGatewayProtocol) {
        self.gateway = gateway
    }

    public func execute() async throws -> Int? {
        try await gateway.execute()
    }
}
