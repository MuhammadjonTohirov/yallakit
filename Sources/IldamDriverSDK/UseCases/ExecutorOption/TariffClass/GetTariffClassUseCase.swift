//
//  GetTariffClassUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol GetTariffClassUseCaseProtocol {
    func fetchServiceTypes() async throws -> [ServiceType]
}

public final class GetTariffClassUseCase: GetTariffClassUseCaseProtocol {
    
    private var gateway:ServiceTypeGatewayProtocol
    
    init(gateway: ServiceTypeGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway =  GetServiceTypeGateway()
    }
    
    public func fetchServiceTypes() async throws -> [ServiceType] {
        let result = try await gateway.getServiceTypes()
        return result.map { ServiceType(from: $0) }
    }
}
