//
//  OrderTariffConfiguratoinUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol OrderTariffConfiguratoinUseCaseProtocol {
    func getOrderTariffConfiguration(orderId: Int) async throws -> OrderTariffConfigurationResponse
}

public final class OrderTariffConfiguratoinUseCase: OrderTariffConfiguratoinUseCaseProtocol {
    
    private let gateway: OrderTariffConfigurationGatewayProtocol
    
    init(gateway: OrderTariffConfigurationGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderTariffConfigurationGateway()
    }
    
    public func getOrderTariffConfiguration(orderId: Int) async throws -> OrderTariffConfigurationResponse {
        
        guard let result = try? await gateway.getOrderTariffConfiguration(orderId: orderId) else {
            throw NSError(domain: "No Order TariffConfiguration found", code: -1)
        }
        return OrderTariffConfigurationResponse(from: result)
    }
}
