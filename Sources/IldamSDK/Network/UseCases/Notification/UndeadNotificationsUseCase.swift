//
//  UnreadNotificationsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol UnreadNotificationsUseCaseProtocol {
    func execute() async throws -> Int?
}

public final class UnreadNotificationsUseCase: UnreadNotificationsUseCaseProtocol {
    private let gateway: UnreadNotificationsGatewayProtocol
    
    init(gateway: UnreadNotificationsGatewayProtocol = UnreadNotificationsGateway()) {
        self.gateway = gateway
    }

    public init() {
        gateway = UnreadNotificationsGateway()
    }

    public func execute() async throws -> Int? {
        try await gateway.execute()
    }
}
