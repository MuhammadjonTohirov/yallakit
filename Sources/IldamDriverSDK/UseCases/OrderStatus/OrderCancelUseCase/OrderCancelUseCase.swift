//
//  OrderCancelUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol OrderCancelUseCaseProtocol {
    func cancelOrder(orderId: Int, reasonId: Int, comment: String) async throws -> OrderCancelResponse
}

public final class OrderCancelUseCase: OrderCancelUseCaseProtocol {
    
    private var gateway: OrderCancelGatewayProtocol
    
    init(gateway: OrderCancelGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderCancelGateway()
    }
    
    public func cancelOrder(orderId: Int, reasonId: Int, comment: String) async throws -> OrderCancelResponse {
        
        guard let result = try? await gateway.cancelOrder(orderId: orderId, reasonId: reasonId, comment: comment) else {
            throw NSError(domain: "No cancelOrder found", code: -1)
        }
        
        return OrderCancelResponse(from: result)
    }
}
