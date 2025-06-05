//
//  DriverPlanListUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverPlanListUseCaseProtocol {
    func execute() async throws -> [DriverPlanListResponse]
}

public final class DriverPlanListUseCase: DriverPlanListUseCaseProtocol {
    
    private let gateway: DriverPlanListProtocol
    
    init(gateway: DriverPlanListProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverPlanListGatewayGetway()
    }
    
    public func execute() async throws -> [DriverPlanListResponse] {
        guard let response = try? await gateway.getPlanLists() else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        return response.map { DriverPlanListResponse(from: $0) }
    }
}
