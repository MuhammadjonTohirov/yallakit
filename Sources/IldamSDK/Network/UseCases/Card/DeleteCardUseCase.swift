//
//  File.swift
//  YallaKit
//
//  Created by applebro on 30/07/25.
//

import Foundation

public protocol DeleteCardUseCaseProtocol {
    func delete(cardId: String) async throws -> Bool
}

public final class DeleteCardUseCase: DeleteCardUseCaseProtocol {
    private let gateway: DeleteCardGatewayProtocol
    
    init(gateway: DeleteCardGatewayProtocol = DeleteCardGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DeleteCardGateway()
    }
    
    public func delete(cardId: String) async throws -> Bool {
        try await gateway.delete(id: cardId) ?? false
    }
}
