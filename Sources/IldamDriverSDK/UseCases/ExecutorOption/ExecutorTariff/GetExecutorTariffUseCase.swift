//
//  GetExecutorTariffUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol GetExecutorTariffUseCaseProtocol {
    func fetchExecutorTariffs() async throws -> ExecutorTariffListResponse
}

public final class GetExecutorTariffUseCase: GetExecutorTariffUseCaseProtocol {
    
    private var gateway: ExecutorTariffGatewayProtocol
    
    init(gateway: ExecutorTariffGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorTariffGateway()
    }
    
    public func fetchExecutorTariffs() async throws -> ExecutorTariffListResponse {
        let result = try await gateway.fetchExecutorTariffs()
        
        return ExecutorTariffListResponse(from: result)
    }
}
