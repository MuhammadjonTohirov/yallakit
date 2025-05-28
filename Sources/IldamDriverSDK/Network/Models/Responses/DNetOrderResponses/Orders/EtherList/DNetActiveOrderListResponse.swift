//
//  DNetActiveOrderListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 27/05/25.
//

import Foundation
// MARK: - Network Response
struct DNetActiveOrderListResponse: Codable {
    let list: [DNetActiveOrder]
    let pagination: DNetActiveOrderPagination

    enum CodingKeys: String, CodingKey {
        case list
        case pagination
    }
}

struct DNetActiveOrder: Codable {
    let addressId: Int
    let brand: DNetResActiveOrderBrand
    let coefficient: Int
    let createdAt: Int
    let detail: DNetActiveOrderDetail
    let directionToClient: DNetActiveDirectionToClient
    let executorBonus: DNetActiveExecutorBonus
    let executorCompensation: DNetActiveExecutorCompensation?
    let executorCoverBonus: DNetActiveExecutorCoverBonus
    let fixedPrice: Bool
    let id: Int
    let paymentType: String
    let routes: [DNetActiveOrderRoute]
    let service: String
    let sourceType: String
    let status: String
    let useTheBonus: Bool

    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case brand
        case coefficient
        case createdAt = "created_at"
        case detail
        case directionToClient = "direction_to_client"
        case executorBonus = "executor_bonus"
        case executorCompensation = "executor_compensation"
        case executorCoverBonus = "executor_cover_bonus"
        case fixedPrice = "fixed_price"
        case id
        case paymentType = "payment_type"
        case routes
        case service
        case sourceType = "source_type"
        case status
        case useTheBonus = "use_the_bonus"
    }
}
struct DNetResActiveOrderBrand: Codable {
    let addressName: String
    let name: String
    let serviceName: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name
        case serviceName = "service_name"
    }
}
struct DNetActiveOrderDetail: Codable {
    let bonusAmount: Int
    let cost: Int
    let modifPrice: Int
    let modifPriceEvent: String
    let services: [DNetActiveOrderService]
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
struct DNetActiveOrderService: Codable {
    let cost: Int
    let costType: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}
struct DNetActiveDirectionToClient: Codable {
    let distance: Double
    let duration: Double
    let mapType: String

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case mapType = "map_type"
    }
}

struct DNetActiveExecutorBonus: Codable {
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
struct DNetActiveExecutorCompensation: Codable {
    let minCost: Double
    let minKm: Double
    let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm  = "min_km"
        case cost
    }
}
struct DNetActiveExecutorCoverBonus: Codable {
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
struct DNetActiveOrderRoute: Codable {
    let coords: DNetActiveOrderCoords
    let lavel1: String
    let level2: String
    
    enum CodingKeys: String, CodingKey {
        case coords
        case lavel1 = "lavel_1"
        case level2 = "level_2"
    }
}
struct DNetActiveOrderCoords: Codable {
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
struct DNetActiveOrderPagination: Codable {
    let count: Int?
    let currentPage: Int?
    let lastPage: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
    }
}
