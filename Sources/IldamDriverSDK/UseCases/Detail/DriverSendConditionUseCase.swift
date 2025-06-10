//
//  DriverSendConditionUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol DriverSendConditionUseCaseProtocol {
    func sendCondition() async throws -> SendConditionResponse
}

public final class DriverSendConditionUseCase: DriverSendConditionUseCaseProtocol {
    
    private let gateway: DriverSendConditionProtocol
    
    init(gateway: DriverSendConditionProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverSendConditionGateway()
    }
    public func sendCondition() async throws -> SendConditionResponse {
        guard let result = try? await gateway.sendCondtion() else {
            throw NSError(domain: "No sendCondition found", code: -1)
        }
        
        return SendConditionResponse(from: result) ?? SendConditionResponse(
            cost: 0,
            deactivation: false,
            description: "No data",
            id: 0,
            limitTime: 0,
            limitUnit: "",
            name: "Unknown",
            orderPayCost: 0,
            orderPayPresent: 0,
            planExpire: 0
        )
    }

}
