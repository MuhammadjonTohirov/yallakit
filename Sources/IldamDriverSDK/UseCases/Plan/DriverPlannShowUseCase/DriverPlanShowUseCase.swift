//
//  DriverPlanShowUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverPlanShowUseCaseProtocol {
    func getPlanShow(id: Int) async throws -> DriverPlanShowResponse
}

public final class DriverPlanShowUseCase: DriverPlanShowUseCaseProtocol {
 
    private let gateway: DriverPlanShowProtocol
    
    init(gateway: DriverPlanShowProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverPlanShowGateway()
    }
    public func getPlanShow(id: Int) async throws -> DriverPlanShowResponse {
        guard let response = try await gateway.getPlanShow(planId: id) else {
            throw NSError(domain: "No PlanShow found", code: -1)

        }
        return response
    }
}
