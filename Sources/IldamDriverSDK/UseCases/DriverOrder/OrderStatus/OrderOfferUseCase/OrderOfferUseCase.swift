//
//  OrderOfferUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol OrderOfferUseCaseProtocol {
    func skipOrder(
        orderId: Int,
        status: String,
        reasonComment: String) async throws -> OrderSkipResponse?
}

public final class OrderOfferUseCase: OrderOfferUseCaseProtocol {
    private let gateway: OrderSkipProtocol
    
    init(gateway: OrderSkipProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderSkipGateway()
    }
    public func skipOrder(orderId: Int, status: String, reasonComment: String) async throws -> OrderSkipResponse? {
        guard let result = try? await gateway.skipOrder(orderId: orderId, status: status, reasonComment: reasonComment) else {
            throw NSError(domain: "No skip Order found", code: -1)
        }
        
        return OrderSkipResponse(from: result)
    }
}
