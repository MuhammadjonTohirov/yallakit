//
//  Untitled.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol ExecutorTariffUseCaseProtocol {
    func fetchExecutorTariffId(tariffId: [Int]) async throws -> Bool
}

public final class ExecutorTariffUseCase: ExecutorTariffUseCaseProtocol {
    private var gateway: UpdateExecutorTariffGatewayProtocol
    
    init(gateway: UpdateExecutorTariffGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateExecutorTariffGateway()
    }
    
    public func fetchExecutorTariffId(tariffId: [Int]) async throws -> Bool {
        return try await gateway.fetchExecutorTariffs(tariffId: tariffId)
    }
}
