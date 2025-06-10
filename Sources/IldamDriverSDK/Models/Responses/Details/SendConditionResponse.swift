//
//  DriverPlan.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI

public struct SendConditionResponse: DNetResBody, Sendable {
    public let cost: Int
    public let deactivation: Bool
    public let description: String
    public let id: Int
    public let limitTime: Int
    public let limitUnit: String
    public let name: String
    public let orderPayCost: Int
    public let orderPayPresent: Int
    public let planExpire: Int

    public init(
        cost: Int,
        deactivation: Bool,
        description: String,
        id: Int,
        limitTime: Int,
        limitUnit: String,
        name: String,
        orderPayCost: Int,
        orderPayPresent: Int,
        planExpire: Int
    ) {
        self.cost = cost
        self.deactivation = deactivation
        self.description = description
        self.id = id
        self.limitTime = limitTime
        self.limitUnit = limitUnit
        self.name = name
        self.orderPayCost = orderPayCost
        self.orderPayPresent = orderPayPresent
        self.planExpire = planExpire
    }

    init?(from network: DNetSendConditionResponse?) {
        guard let plan = network?.plan else {
            return nil
        }
        
        self.cost = plan.cost
        self.deactivation = plan.deactivation
        self.description = plan.description
        self.id = plan.id
        self.limitTime = plan.limitTime
        self.limitUnit = plan.limitUnit
        self.name = plan.name
        self.orderPayCost = plan.orderPayCost
        self.orderPayPresent = plan.orderPayPresent
        self.planExpire = plan.planExpire
    }
}
