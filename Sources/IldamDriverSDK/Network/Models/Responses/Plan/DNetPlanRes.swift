//
//  DNetPlanRes.swift
//  YallaKit
//
//  Created by MuhammadAli on 05/06/25.
//

import Foundation

struct DNetPlanRes: DNetResBody, Sendable {
    let condition: Bool
    let plan: DNetBuyPlanResult
    
   
}
struct DNetBuyPlanResult: Codable, Sendable {
    let id: Int
    let addressId: Int
    let cost: Int
    let deactivation: Bool
    let description: String
    let limitTime: Int
    let limitUnit: String
    let name: String
    let orderPayCost: Int
    let orderPayPresent: Int

    enum CodingKeys: String, CodingKey {
        case id
        case addressId = "address_id"
        case cost
        case deactivation
        case description
        case limitTime = "limit_time"
        case limitUnit = "limit_unit"
        case name
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
}

    
