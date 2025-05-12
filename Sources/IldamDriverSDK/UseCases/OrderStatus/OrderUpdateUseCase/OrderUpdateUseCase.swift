//
//  OrderUpdateUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol OrderUpdateUseCaseProtocol {
    func updateOrderStatus(id: Int) async throws -> OrderUpdateResponse
}

public final class OrderUpdateUseCase: OrderUpdateUseCaseProtocol {
    private var gateway: OrderStatusUpdateGetwayProtocol
    
    init(gateway: OrderStatusUpdateGetwayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = OrderStatusUpdateGetway()
    }
    
    public func updateOrderStatus(id: Int) async throws -> OrderUpdateResponse {
         
        guard let result = try await gateway.orderUpdate(orderId: id) else {
            throw NSError(domain: "No updateOrderStatus found", code: -1)
        }
        return OrderUpdateResponse(from: result)
    }
    
     
}
