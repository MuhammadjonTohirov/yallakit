//
//  OrderComplateUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol OrderComplateUseCaseProtocol {
    func complateOrder(orderId: Int, body: TripCalculationBody) async throws -> TripCalculationResponse
}

public final class OrderComplateUseCase: OrderComplateUseCaseProtocol {
    public func complateOrder(orderId: Int, body: TripCalculationBody) async throws -> TripCalculationResponse {
        guard let result = try await gateway.complateOrder(orderId: orderId, body: body) else {
            throw NSError(domain: "No order found", code: -1)
        }
        return TripCalculationResponse(from: result)
    }
    
    private var gateway: OrderComplateProtocol
    
    init(gateway: OrderComplateProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderComplateGateway()
    }
}
