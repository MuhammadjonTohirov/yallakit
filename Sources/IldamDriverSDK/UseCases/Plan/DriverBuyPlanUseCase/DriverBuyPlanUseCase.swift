//
//  DriverBuyPlanUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverBuyPlanUseCaseProtocol {
    func execute(planId: Int) async throws -> DriverBuyPlanResponse
}

public final class DriverBuyPlanUseCase: DriverBuyPlanUseCaseProtocol {
    
    private let gateway: DriverBuyPlanProtocol
    
    init(gateway: DriverBuyPlanProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverBuyPlanGateway()
        
    }
    
    public func execute(planId: Int) async throws -> DriverBuyPlanResponse {
        guard let result = try? await gateway.buyPlan(planId: planId),
              let response = DriverBuyPlanResponse(network: result) else {
            throw NSError(domain: "No configuration found", code: -1)
        }

        return response
    }

}

