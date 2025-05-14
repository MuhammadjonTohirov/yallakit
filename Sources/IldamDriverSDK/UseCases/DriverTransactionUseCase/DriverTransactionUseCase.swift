//
//  DriverTransactionUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol DriverTransactionUseCaseProtocol {
    func fetchTransactions(type: String) async throws -> DriverTransactionModel
}

public final class DriverTransactionUseCase: DriverTransactionUseCaseProtocol {
    
    private var gateway: DriverTransactionGatewayProtocol
    
    init(gateway: DriverTransactionGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverTransactionGateway()
    }
    
    public func fetchTransactions(type: String) async throws -> DriverTransactionModel {
        
        let result = try await gateway.fetchTransactions(type: type)
        
        return DriverTransactionModel(from: result)
    }
}
