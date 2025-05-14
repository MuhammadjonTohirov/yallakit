//
//  DriverConditionGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//
//DriverSendConditionGetway
import Foundation

struct DNetSendConditionResponse: DNetResBody {
    let activeTransport: Bool
    let condition: Bool
    let plan: DNetSendConditionPlan?
    
    enum CodingKeys: String, CodingKey {
        case activeTransport = "active_transport"
        case condition
        case plan
    }
    
    struct DNetSendConditionPlan: Codable {
        let cost: Int
        let deactivation: Bool
        let description: String
        let id: Int
        let limitTime: Int
        let limitUnit: String
        let name: String
        let orderPayCost: Int
        let orderPayPresent: Int
        let planExpire: Int
        
        enum CodingKeys: String, CodingKey {
            case cost
            case deactivation
            case description
            case id
            case limitTime = "limit_time"
            case limitUnit = "limit_unit"
            case name
            case orderPayCost = "order_pay_cost"
            case orderPayPresent = "order_pay_present"
            case planExpire = "plan_expire"
        }
    }
}

