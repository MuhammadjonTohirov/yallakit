//
//  ExecutorOrderShowHistoryUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol ExecutorOrderShowHistoryUseCaseProtocol {
    func fetchOrderHistoryShow(orderId: Int) async throws -> ExecutorOrderShowHistoryResponse
}

public final class ExecutorOrderShowHistoryUseCase: ExecutorOrderShowHistoryUseCaseProtocol {
    
    private var gateway: OrderHistoryShowGatewayProtocol
    
    init(gateway: OrderHistoryShowGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorOrderShowHistoryGateway()
    }
    
    public func fetchOrderHistoryShow(orderId: Int) async throws -> ExecutorOrderShowHistoryResponse {
        
        let result = try await gateway.fetchOrderHistoryShow(orderId: orderId)
        
        return ExecutorOrderShowHistoryResponse(from: result)
    }
}
