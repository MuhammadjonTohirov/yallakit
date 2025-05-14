//
//  DriverRemovePlanUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverRemovePlanUseCaseProtocol {
    func removePlanId(planId: Int) async throws -> DriverRemovePlanResponse
}

public final class DriverRemovePlanUseCase: DriverRemovePlanUseCaseProtocol {
    private let gateway: DriverRemovePlanProtocol
    
    init(gateway: DriverRemovePlanProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverRemovePlanGateway()
    }
    
    public func removePlanId(planId: Int) async throws -> DriverRemovePlanResponse {
            
        guard let response = try? await gateway.removePlan(planId: planId) else {
            throw NSError(domain: "No PlanShow found", code: -1)
        }
        return response
    }
}
