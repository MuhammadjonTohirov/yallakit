//
//  UpdateOrderPaymentMethodUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 09/02/26.
//

import Foundation

public protocol UpdateOrderPaymentMethodUseCaseProtocol: Sendable {
    func execute(orderId: Int, cardId: String?, type: String) async throws -> Bool
    
    func updateToCash(orderId: Int) async throws -> Bool
    
    func updateToCard(orderId: Int, cardId: String) async throws -> Bool
}

public struct UpdateOrderPaymentMethodUseCase: UpdateOrderPaymentMethodUseCaseProtocol {
    private let gateway: UpdateOrderPaymentMethodGatewayProtocol
    
    init(gateway: UpdateOrderPaymentMethodGatewayProtocol = UpdateOrderPaymentMethodGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateOrderPaymentMethodGateway()
    }
    
    public func execute(orderId: Int, cardId: String?, type: String) async throws -> Bool {
        return try await gateway.update(orderId: orderId, cardId: cardId, type: type)
    }
    
    public func updateToCash(orderId: Int) async throws -> Bool {
        try await execute(orderId: orderId, cardId: nil, type: "cash")
    }
    
    public func updateToCard(orderId: Int, cardId: String) async throws -> Bool {
        try await execute(orderId: orderId, cardId: cardId, type: "card")
    }
}
