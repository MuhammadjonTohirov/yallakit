//
//  LoadNotificationsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol LoadNotificationsUseCaseProtocol {
    func execute(page: Int, perPage: Int) async throws -> NotificationsResponse?
}

public final class LoadNotificationsUseCase: LoadNotificationsUseCaseProtocol {
    var gateway: any LoadNotificationsGatewayProtocol = LoadNotificationsGateway()
    
    init(gateway: any LoadNotificationsGatewayProtocol = LoadNotificationsGateway()) {
        self.gateway = gateway
    }

    public init() {}

    public func execute(page: Int, perPage: Int) async throws -> NotificationsResponse? {
        NotificationsResponse(res: try await gateway.load(page: page, perPage: perPage))
    }
}
