//
//  OrderShowResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import SwiftUI
import NetworkLayer

struct DNetOrderShowResponse: DNetResBody {
    let addressId: Int
    let brand: DNetOrderShowBrand
    let clientPhone: String
    let coefficient: Double
    let createdAt: Int
    let detail: DNetOrderShowDetail
    let directionToClient: DNetOrderShowDirectionToClient
    let dontCallMe: Bool
    let energy: DNetOrderShowEnergy
    let executorBonus: DNetOrderShowExecutorBonus
    let executorCompensation: DNetOrderShowExecutorCompensation?
    let executorCoverBonus: DNetOrderShowExecutorCoverBonus
    let fixedPrice: Bool
    let id: Int
    let paymentType: String
    let reason: DNetOrderShowCancelReason?
    let roadDirection: DNetOrderRoadDirection
    let routes: [DNetOrderRoute]
    let sendingTime: Int
    let service: DNetOrderShowService
    let sourceType: String
    let status: String
    let statusTime: [DNetOrderShowStatusTime]?
    let toPhone: String
    let useTheBonus: Bool
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case brand
        case clientPhone = "client_phone"
        case coefficient
        case createdAt = "created_at"
        case detail
        case directionToClient = "direction_to_client"
        case dontCallMe = "dont_call_me"
        case energy
        case executorBonus = "executor_bonus"
        case executorCompensation = "executor_compensation"
        case executorCoverBonus = "executor_cover_bonus"
        case fixedPrice = "fixed_price"
        case id
        case paymentType = "payment_type"
        case reason
        case roadDirection = "road_direction"
        case routes
        case sendingTime = "sending_time"
        case service
        case sourceType = "source_type"
        case status
        case statusTime = "status_time"
        case toPhone = "to_phone"
        case useTheBonus = "use_the_bonus"
    }
    
    struct DNetOrderShowBrand: Codable {
        let addressName: String
        let name: String
        let serviceName: String
        
        enum CodingKeys: String, CodingKey {
            case addressName = "address_name"
            case name
            case serviceName = "service_name"
        }
    }
    
    struct DNetOrderShowDetail: Codable {
        let approxDistance: Double
        let approxDuration: Double
        let approxTotalPrice: Int
        let bonusAmount: Int
        let comment: String
        let cost: Int
        let distance: Int
        let duration: String
        let modifPrice: Int
        let modifPriceEvent: String
        let services: [DNetOrderShowService]?
        let tariffName: String
        
        enum CodingKeys: String, CodingKey {
            case approxDistance = "approx_distance"
            case approxDuration = "approx_duration"
            case approxTotalPrice = "approx_total_price"
            case bonusAmount = "bonus_amount"
            case comment
            case cost
            case distance
            case duration
            case modifPrice = "modif_price"
            case modifPriceEvent = "modif_price_event"
            case services
            case tariffName = "tariff_name"
        }
    }
    
    struct DNetOrderShowDirectionToClient: Codable {
        let distance: Double
        let duration: Double
        let mapType: String
        
        enum CodingKeys: String, CodingKey {
            case distance
            case duration
            case mapType = "map_type"
        }
    }
    
    struct DNetOrderShowEnergy: Codable {
        let cancel: Int
        let km: Int
        let minus: Int
        let plus: Int
    }
    
    struct DNetOrderShowExecutorBonus: Codable {
        let cost: Int
        let minCost: Int
        let minKm: Int
        let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case cost
            case minCost = "min_cost"
            case minKm = "min_km"
            case status
        }
    }
    
    struct DNetOrderShowExecutorCoverBonus: Codable {
        let approxPrice: Int
        let calculationType: String
        let cost: Int
        let distance: Int
        let duration: Int
        let status: Bool
        
        enum CodingKeys: String, CodingKey {
            case approxPrice = "approx_price"
            case calculationType = "calculation_type"
            case cost
            case distance
            case duration
            case status
        }
    }
    
    struct DNetOrderShowExecutorCompensation: Codable {
        let minCost: Double
        let minKm: Double
        let cost: Double
        
        enum CodingKeys: String, CodingKey {
            case minCost = "min_cost"
            case minKm  = "min_km"
            case cost
        }
    }
    
    struct DNetOrderRoadDirection: Codable {
        let distance: Int
        let duration: Int
    }
    
    struct DNetOrderRoute: Codable {
        let coords: Coords
        let lavel1: String
        let level2: String
        
        enum CodingKeys: String, CodingKey {
            case coords
            case lavel1 = "lavel_1"
            case level2 = "level_2"
        }
        
        struct Coords: Codable {
            let lat: Double
            let lng: Double
        }
    }
    
    struct DNetOrderShowCancelReason: Codable {
        let id: Int
        let name: String
    }
    
    struct DNetOrderShowStatusTime: Codable {
        var status: String?
        let time: Int?
    }

}
struct DNetOrderShowService: Codable {
    let cost: Int
    let costType, name: String
    
    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}
