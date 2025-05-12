//
//  DriverAddCardUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol DriverSelectDefaultCardUseCaseProtocol {
    func getDefaultCard(cardId: String) async throws -> Bool
}

public final class DriverSelectDefaultCardUseCase: DriverSelectDefaultCardUseCaseProtocol {
    
    private let gateway: DriverDefaultCardPrpotocol
    
    init(gateway: DriverDefaultCardPrpotocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverDefaultCardGateway()
    }
    
    public func getDefaultCard(cardId: String) async throws -> Bool {
        return try await gateway.getDefaultCard(cardId: cardId) ?? false
    }
}
