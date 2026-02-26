//
//  ShowAndReadNotifUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol ShowAndReadNotifUseCaseProtocol: Sendable {
    func execute(notifId: Int64) async throws -> NotificationItem?
}

public struct ShowAndReadNotifUseCase: ShowAndReadNotifUseCaseProtocol, Sendable {
    private let gateway: ShowAndReadNotifGateway

    public init() {
        self.gateway = ShowAndReadNotifGatewayImpl()
    }

    init(gateway: ShowAndReadNotifGateway) {
        self.gateway = gateway
    }

    public func execute(notifId: Int64) async throws -> NotificationItem? {
        let result = try await gateway.execute(notificationId: notifId)
        return NotificationItem(res: result)
    }
}
