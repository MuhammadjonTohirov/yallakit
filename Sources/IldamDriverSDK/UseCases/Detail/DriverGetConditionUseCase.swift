//
//  DriverGetConditionUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverGetConditionUseCaseProtocol {
    func execute() async throws -> DriverGetConditionResponse
}

public final class DriverGetConditionUseCase: DriverGetConditionUseCaseProtocol {
    private let gateway: GetConditionGatewayProtocol
    
    public func execute() async throws -> DriverGetConditionResponse {
        
        guard let result = try await gateway.getCondition() else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        return DriverGetConditionResponse(from: result)
    }
    
    init(gateway: GetConditionGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverGetConditionGateway()
    }
}
