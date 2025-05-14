//
//  DriverRemovePlanResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation

public struct DriverRemovePlanResponse: DNetResBody {
    public let condition: Bool
    public let plan: DriverPlan?
    
    public init(condition: Bool, plan: DriverPlan?) {
        self.condition = condition
        self.plan = plan
    }
    init(from network: DNetResRemovePlanShow) {
        self.condition = network.condition
        self.plan = network.plan.map {
            DriverPlan(
                addressId: $0.addressId,
                cost: $0.cost,
                deactivation: $0.deactivation,
                description: $0.description,
                id: $0.id,
                limitTime: $0.limitTime,
                limitUnit: $0.limitUnit,
                name: $0.name,
                orderPayCost: $0.orderPayCost,
                orderPayPresent: $0.orderPayPresent
            )
        }
    }
}
