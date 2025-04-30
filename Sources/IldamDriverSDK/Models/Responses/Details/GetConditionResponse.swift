//
//  GetConditionResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//
import SwiftUI

public struct DriverGetConditionResponse: DNetResBody {
    public let activeTransport: Bool
    public let condition: Bool
    public let plan: GetConditionDriverPlan

    public init(
        activeTransport: Bool,
        condition: Bool,
        plan: GetConditionDriverPlan
    ) {
        self.activeTransport = activeTransport
        self.condition = condition
        self.plan = plan
    }

    init(from network: DNetGetConditionResponse) {
        self.activeTransport = network.activeTransport
        self.condition = network.condition
        self.plan = GetConditionDriverPlan(
            cost: network.plan.cost,
            deactivation: network.plan.deactivation,
            description: network.plan.description,
            id: network.plan.id,
            limitTime: network.plan.limitTime,
            limitUnit: network.plan.limitUnit,
            name: network.plan.name,
            orderPayCost: network.plan.orderPayCost,
            orderPayPresent: network.plan.orderPayPresent,
            planExpire: network.plan.planExpire
        )
    }
}

public struct GetConditionDriverPlan: Codable {
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

    init(from network:  DNetGetConditionPlan) {
        self.cost = network.cost
        self.deactivation = network.deactivation
        self.description = network.description
        self.id = network.id
        self.limitTime = network.limitTime
        self.limitUnit = network.limitUnit
        self.name = network.name
        self.orderPayCost = network.orderPayCost
        self.orderPayPresent = network.orderPayPresent
        self.planExpire = network.planExpire
    }
}
