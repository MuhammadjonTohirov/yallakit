//
//  LoadNotificationsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol LoadNotificationsUseCaseProtocol: Sendable {
    func execute(page: Int, perPage: Int) async throws -> NotificationsResponse?
}

public struct LoadNotificationsUseCase: LoadNotificationsUseCaseProtocol, Sendable {
    private let gateway: LoadNotificationsGatewayProtocol

    public init() {
        self.gateway = LoadNotificationsGateway()
    }

    init(gateway: LoadNotificationsGatewayProtocol) {
        self.gateway = gateway
    }

    public func execute(page: Int, perPage: Int) async throws -> NotificationsResponse? {
        NotificationsResponse(res: try await gateway.load(page: page, perPage: perPage))
    }
}
