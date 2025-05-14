//
//  DNetResPlanShowResult.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import SwiftUI

struct DNetResRemovePlanShow: DNetResBody {
    let condition: Bool
    let plan: RemovePlanRes?
}
 
struct RemovePlanRes: Codable {
    let addressId: Int
    let cost: Int
    let deactivation: Bool
    let description: String
    let id: Int
    let limitTime: Int
    let limitUnit: String
    let name: String
    let orderPayCost: Int
    let orderPayPresent: Int

    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case cost
        case deactivation
        case description
        case id
        case limitTime = "limit_time"
        case limitUnit = "limit_unit"
        case name
        case orderPayCost = "order_pay_cost"
        case orderPayPresent = "order_pay_present"
    }
}
