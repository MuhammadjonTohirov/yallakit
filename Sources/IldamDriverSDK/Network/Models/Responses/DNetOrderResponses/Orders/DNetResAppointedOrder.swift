//
//  OrderAppointedBrand.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

import Foundation

struct DNetResAppointedOrder: DNetResBody {
    let addressId: Int
    let brand: DNetAppointedOrderBrand
    let clientPhone: String
    let coefficient: Double
    let createdAt: Int
    let detail: DNetAppointedOrderDetail
    let directionToClient: DNetAppointedOrderDirectionToClient
    let dontCallMe: Bool
    let energy: DNetAppointedOrderEnergy
    let executorBonus: DNetAppointedOrderExecutorBonus
    let executorCompensation: DNetAppointedOrderExecutorCompensation?
    let executorCoverBonus: DNetAppointedOrderExecutorCoverBonus
    let fixedPrice: Bool
    let id: Int
    let paymentType: String
    let reason: DNetAppointedOrderReason?
    let roadDirection: DNetAppointedOrderRoadDirection
    let routes: [DNetAppointedOrderRoute]
    let sendingTime: Int
    let service: String
    let sourceType: String
    let status: String
    let statusTime: [DNetAppointedOrderStatusTime]
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
}

struct DNetAppointedOrderBrand: Codable {
    let addressName: String
    let name: String
    let serviceName: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name
        case serviceName = "service_name"
    }
}

struct DNetAppointedOrderDetail: Codable {
    let approxDistance: Double
    let approxDuration: Double
    let approxTotalPrice: Double
    let bonusAmount: Int
    let comment: String
    let cost: Double
    let distance: Double
    let duration: String
    let modifPrice: Double
    let modifPriceEvent: String
    let services: [DNetAppointedOrderService]?
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

struct DNetAppointedOrderService: Codable {
    let cost: Int
    let costType: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}

struct DNetAppointedOrderDirectionToClient: Codable {
    let distance: Double
    let duration: Double
    let mapType: String

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case mapType = "map_type"
    }
}

struct DNetAppointedOrderEnergy: Codable {
    let cancel: Int
    let km: Int
    let minus: Int
    let plus: Int
}

struct DNetAppointedOrderExecutorBonus: Codable {
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

struct DNetAppointedOrderExecutorCompensation: Codable {
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

struct DNetAppointedOrderExecutorCoverBonus: Codable {
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

struct DNetAppointedOrderRoadDirection: Codable {
    let distance: Int
    let duration: Int
}

struct DNetAppointedOrderRoute: Codable {
    let coords: DNetAppointedOrderCoords
    let lavel1: String
    let level2: String

    enum CodingKeys: String, CodingKey {
        case coords
        case lavel1 = "lavel_1"
        case level2 = "level_2"
    }
}

struct DNetAppointedOrderCoords: Codable {
    let lat: Double
    let lng: Double
}

struct DNetAppointedOrderStatusTime: Codable {
    let status: String
    let time: Int
}
struct DNetAppointedOrderReason: Codable {
    let id: Int
    let name: String
}
