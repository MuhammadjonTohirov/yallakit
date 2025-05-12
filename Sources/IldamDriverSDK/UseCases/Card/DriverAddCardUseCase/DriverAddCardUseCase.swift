//
//  DriverAddCardUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol DriverAddCardUseCaseProtocol {
    func addCard(number: String, expiry: String) async throws -> CardAddedResponse
}

public final class DriverAddCardUseCase: DriverAddCardUseCaseProtocol {
    
    private let gateway: AddCardGatewayProtocol
    
    init(gateway: AddCardGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverAddCardGateway()
    }
    
    public func addCard(number: String, expiry: String) async throws -> CardAddedResponse {
        guard let result = try await gateway.addCard(number: number, expiry: expiry) else {
            throw NSError(domain: "Add Card has failed", code: -1)
        }
        return CardAddedResponse(from: result)
    }
}
