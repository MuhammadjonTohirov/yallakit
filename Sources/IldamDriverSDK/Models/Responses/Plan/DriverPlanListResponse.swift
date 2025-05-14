//
//  ExecutorPlanModel.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public struct DriverPlanListResponse {
    public let addressId: Int
    public let cost: Int
    public let deactivation: Bool
    public let description: String
    public let id: Int
    public let limitTime: Int
    public let limitUnit: String
    public let name: String
    public let orderPayCost: Int
    public let orderPayPresent: Int

    public init(
        addressId: Int,
        cost: Int,
        deactivation: Bool,
        description: String,
        id: Int,
        limitTime: Int,
        limitUnit: String,
        name: String,
        orderPayCost: Int,
        orderPayPresent: Int
    ) {
        self.addressId = addressId
        self.cost = cost
        self.deactivation = deactivation
        self.description = description
        self.id = id
        self.limitTime = limitTime
        self.limitUnit = limitUnit
        self.name = name
        self.orderPayCost = orderPayCost
        self.orderPayPresent = orderPayPresent
    }

    // Internal init from network
    init(from network: DNetResExecutorPlanResult) {
        self.addressId = network.addressId
        self.cost = network.cost
        self.deactivation = network.deactivation
        self.description = network.description
        self.id = network.id
        self.limitTime = network.limitTime
        self.limitUnit = network.limitUnit
        self.name = network.name
        self.orderPayCost = network.orderPayCost
        self.orderPayPresent = network.orderPayPresent
    }
}
