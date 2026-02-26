//
//  File.swift
//  YallaKit
//
//  Created by applebro on 30/07/25.
//

import Foundation

public protocol DeleteCardUseCaseProtocol: Sendable {
    func delete(cardId: String) async throws -> Bool
}

public struct DeleteCardUseCase: DeleteCardUseCaseProtocol, Sendable {
    private let gateway: DeleteCardGatewayProtocol

    public init() {
        self.gateway = DeleteCardGateway()
    }

    init(gateway: DeleteCardGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func delete(cardId: String) async throws -> Bool {
        try await gateway.delete(id: cardId) ?? false
    }
}
