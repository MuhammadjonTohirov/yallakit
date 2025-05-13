//
//  FillDriverCardToBalanceUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol FillDriverCardToBalanceUseCaseProtocol {
    func getDefaultCard(cardId: String, amount: Double) async throws -> Bool
}

public final class FillDriverCardToBalanceUseCase: FillDriverCardToBalanceUseCaseProtocol {
    
    private var gateway: FillDriverCardToBalanceProtocol
    
    init(gateway: FillDriverCardToBalanceProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = FillDriverCardToBalanceGateway()
    }
    
    public func getDefaultCard(cardId: String, amount: Double) async throws -> Bool {
        
        guard let result = try await gateway.getDefaultCard(cardId: cardId, amount: amount) else {
            return false
        }
        return true
    }
}
