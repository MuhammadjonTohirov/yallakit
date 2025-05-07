//
//  DriverStatistics.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public struct DriverStatisticsResponse {
    public let cash: Int
    public let card: Int
    public let orderCount: Int
    public let distance: Int
    public let netProfit: Int
    public let totalPrice: Int
    public let transferFromClient: Int
    public let bonus: Int
    public let allBonus: AllBonus
    public let commission: Int
    public let data: [Int]
    public let labels: [String]
    public struct AllBonus {
        public let planAward: Int
        public let compensation: Int
        public let bonusToCover: Int

        public init(planAward: Int, compensation: Int, bonusToCover: Int) {
            self.planAward = planAward
            self.compensation = compensation
            self.bonusToCover = bonusToCover
        }
        init(from network: DNetStatisticsResponse.AllBonus) {
            self.planAward = network.planAward
            self.compensation = network.compensation
            self.bonusToCover = network.bonusToCover
        }
    }

    public init(cash: Int, card: Int, orderCount: Int, distance: Int, netProfit: Int, totalPrice: Int, transferFromClient: Int, bonus: Int, allBonus: AllBonus, commission: Int, data: [Int], labels: [String]) {
        self.cash = cash
        self.card = card
        self.orderCount = orderCount
        self.distance = distance
        self.netProfit = netProfit
        self.totalPrice = totalPrice
        self.transferFromClient = transferFromClient
        self.bonus = bonus
        self.allBonus = allBonus
        self.commission = commission
        self.data = data
        self.labels = labels
    }
    init(from network: DNetStatisticsResponse) {
        self.cash = network.cash
        self.card = network.card
        self.orderCount = network.orderCount
        self.distance = network.distance
        self.netProfit = network.netProfit
        self.totalPrice = network.totalPrice
        self.transferFromClient = network.transferFromClient
        self.bonus = network.bonus
        self.allBonus = AllBonus(from: network.allBonus)
        self.commission = network.commission
        self.data = network.data
        self.labels = network.labels
    }
}
