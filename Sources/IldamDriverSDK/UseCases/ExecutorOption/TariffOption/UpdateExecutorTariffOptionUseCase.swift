//
//  UpdateExecutorOptionUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol UpdateExecutorTariffOptionUseCaseProtocol {
    func sendTariffOption(tariffId: [Int]) async throws -> Bool?
}
public final class UpdateExecutorTariffOptionUseCase: UpdateExecutorTariffOptionUseCaseProtocol {
    
    private var gateway: SendServiceTypeProtocol
    
    init(gateway: SendServiceTypeProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateExecutorTariffOptionGateway()
    }
    
    public func sendTariffOption(tariffId: [Int]) async throws -> Bool? {
        
        return try await gateway.sendTariffOption(tariffId: tariffId)
        
    }
}
