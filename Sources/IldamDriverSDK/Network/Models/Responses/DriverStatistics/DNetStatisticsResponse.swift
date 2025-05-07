//
//  ChartData.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//
import Foundation

struct DNetStatisticsResponse: DNetResBody {
    let cash: Int
    let card: Int
    let orderCount: Int
    let distance: Int
    let netProfit: Int
    let totalPrice: Int
    let transferFromClient: Int
    let bonus: Int
    let allBonus: AllBonus
    let commission: Int
    let data: [Int]
    let labels: [String]

    enum CodingKeys: String, CodingKey {
        case cash, card
        case orderCount = "order_count"
        case distance
        case netProfit = "net_profit"
        case totalPrice = "total_price"
        case transferFromClient = "transfer_from_client"
        case bonus
        case allBonus = "all_bonus"
        case commission = "comission"
        case data, labels
    }

    struct AllBonus: Codable {
        let planAward: Int
        let compensation: Int
        let bonusToCover: Int

        enum CodingKeys: String, CodingKey {
            case planAward = "plan_award"
            case compensation
            case bonusToCover = "bonus_to_cover"
        }
    }
}
