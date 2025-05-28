//
//  DNetOrderSentToEther.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//

import Foundation

struct DNetOrderSentToEtherResult: DNetResBody {
    let addressID: Int?
    let brand: DNetOrderSentToEtherBrand?
    let clientPhone: String?
    let coefficient: Double?
    let createdAt: Double?
    let detail: DNetOrderSentToEtherDetail?
    let directionToClient: DNetOrderSentToEtherDirectionToClient?
    let dontCallMe: Bool?
    let energy: DNetOrderSentToEtherEnergy?
    let executorCompensation: DNetOrderSentToEtherExecutorCompensation?
    let executorCoverBonus: DNetOrderSentToEtherExecutorCoverBonus?
    let executorBonus: DNetOrderSentToEtherExecutorBonus?
    let fixedPrice: Bool?
    let id: Int?
    let paymentType: String?
    let reason: DNetOrderSentToEtherReason?
    let roadDirection: DNetOrderSentToEtherDirectionToClient?
    let routes: [DNetOrderSentToEtherRoute]?
    let sendingTime: Int?
    let service: String?
    let sourceType, status: String?
    let statusTime: [DNetOrderSentToEtherStatusTime]?
    let toPhone: String?
    let useTheBonus: Bool?
    
    enum CodingKeys: String, CodingKey {
        case addressID = "address_id"
        case brand
        case clientPhone = "client_phone"
        case coefficient
        case createdAt = "created_at"
        case detail
        case directionToClient = "direction_to_client"
        case dontCallMe = "dont_call_me"
        case energy
        case executorCompensation = "executor_compensation"
        case executorCoverBonus = "executor_cover_bonus"
        case executorBonus = "executor_bonus"
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
}
struct DNetOrderSentToEtherBrand: Codable {
    let addressName: String
    let name: String
    let serviceName: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name
        case serviceName = "service_name"
    }
}
struct DNetOrderSentToEtherDetail: Codable {
    let bonusAmount: Int
    let cost: Int
    let modifPrice: Int
    let modifPriceEvent: String
    let services: [DNetOrderSentToExecutorService]
    let tariffName: String

    enum CodingKeys: String, CodingKey {
        case bonusAmount = "bonus_amount"
        case cost
        case modifPrice = "modif_price"
        case modifPriceEvent = "modif_price_event"
        case services
        case tariffName = "tariff_name"
    }
}
struct DNetOrderSentToEtherService: Codable {
    let cost: Int
    let costType: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}
struct DNetOrderSentToEtherReason: Codable {
    let id: Int
    let name: String
}

struct DNetOrderSentToEtherDirectionToClient: Codable {
    let distance: Double?
    let duration: Double?
    let mapType: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case mapType = "map_type"
    }
}
struct DNetOrderSentToEtherExecutorCompensation: Codable {
    let minCost: Double
    let minKm: Double
    let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm  = "min_km"
        case cost
    }
}
struct DNetOrderSentToEtherExecutorCoverBonus: Codable {
    let approxPrice: Int
    let calculationType: String
    let cost: Int
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case approxPrice = "approx_price"
        case calculationType = "calculation_type"
        case cost
        case status
    }
}
struct DNetOrderSentToEtherExecutorBonus: Codable {
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
struct DNetOrderSentToEtherRoute: Codable {
    let coords: DNetOrderSentToEtherCoords
    let lavel1: String
    let level2: String
    
    enum CodingKeys: String, CodingKey {
        case coords
        case lavel1 = "lavel_1"
        case level2 = "level_2"
    }
}
struct DNetOrderSentToEtherCoords: Codable {
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
struct DNetOrderSentToEtherEnergy: Codable {
    let cancel, km, minus, plus: Int
}

struct DNetOrderSentToEtherStatusTime: Codable {
    var status: String?
    let time: Int?
}

