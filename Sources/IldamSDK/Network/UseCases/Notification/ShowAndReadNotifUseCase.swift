//
//  ShowAndReadNotifUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol ShowAndReadNotifUseCaseProtocol {
    func execute(notifId: Int) async throws -> NotificationItem?
}

public final class ShowAndReadNotifUseCase: ShowAndReadNotifUseCaseProtocol {
    let gateway = ShowAndReadNotifGatewayImpl()
    
    public init() {}
    
    public func execute(notifId: Int) async throws -> NotificationItem? {
        let result = try await gateway.execute(notificationId: notifId)
        return NotificationItem(res: result)
    }
}
