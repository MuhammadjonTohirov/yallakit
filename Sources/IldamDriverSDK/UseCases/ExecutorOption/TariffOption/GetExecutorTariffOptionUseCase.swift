//
//  ExecutorOptionUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol GetExecutorTariffOptionUseCaseProtocol {
    func excuteTariffOption() async throws -> ExecutorServiceOptionsResponse
}
public final class GetExecutorTariffOptionUseCase: GetExecutorTariffOptionUseCaseProtocol {
    
    private let gateway: ExecutorServiceOptionsGatewayProtocol
    
    init(gateway: ExecutorServiceOptionsGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetExecutorTariffOptionGateway()
    }
    
    public func excuteTariffOption() async throws -> ExecutorServiceOptionsResponse {
        
        guard let result = try? await gateway.fetchServiceOptions() else {
            throw NSError(domain: "No excute Tariff Option", code: -1)
        }
        
        return ExecutorServiceOptionsResponse(from: result)
    }
}
