//
//  EtherResult.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import SwiftUI
import NetworkLayer

struct DNetResEtherResponse: NetResBody {
    let list: [DNetResEtherList]
    let pagination: DNetResPagination

    enum CodingKeys: String, CodingKey {
        case list
        case pagination
    }
}

struct DNetResEtherList: Codable {
    let addressId: Int
    let brand: DNetResEtherOrderBrand
    let counterparty: Bool
    let createdAt: Int
    let detail: DNetResEtherOrderDetail
    let directionToClient: DNetResEtherDirectionToClient
    let executorBonus: DNetResEtherExecutorBonus
    let executorCompensation: DNetResEtherExecutorCompensation?
    let executorCoverBonus: DNetResEtherExecutorCoverBonus
    let fixedPrice: Bool
    let id: Int
    let paymentType: String
    let routes: [DNetResEtherOrderRoute]
    let service: String
    let status: String
    let useTheBonus: Bool

    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case brand
        case counterparty
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
        case status
        case useTheBonus = "use_the_bonus"
    }
}

struct DNetResEtherOrderBrand: Codable {
    let addressName: String
    let name: String
    let serviceName: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name
        case serviceName = "service_name"
    }
}

struct DNetResEtherOrderDetail: Codable {
    let approxDistance: Double?
    let approxDuration: Double?
    let approxTotalPrice: Double?
    let cost: Double?
    let modifPrice: Double?
    let modifPriceEvent: String?
    let services: [DNetResEtherOrderService]?
    let tariffName: String

    enum CodingKeys: String, CodingKey {
        case approxDistance = "approx_distance"
        case approxDuration = "approx_duration"
        case approxTotalPrice = "approx_total_price"
        case cost
        case modifPrice = "modif_price"
        case modifPriceEvent = "modif_price_event"
        case services
        case tariffName = "tariff_name"
    }
}


struct DNetResEtherDirectionToClient: Codable {
    let distance: Double
    let duration: Double
    let mapType: String

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case mapType = "map_type"
    }
}

struct DNetResEtherExecutorBonus: Codable {
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

struct DNetResEtherExecutorCompensation: Codable {
    let minCost: Double
    let minKm: Double
    let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm  = "min_km"
        case cost
    }
}

struct DNetResEtherExecutorCoverBonus: Codable {
    let calculationType: String
    let cost: Int
    let status: Bool

    enum CodingKeys: String, CodingKey {
        case calculationType = "calculation_type"
        case cost
        case status
    }
}


struct DNetResEtherOrderRoute: Codable {
    let coords: DNetResEtherCoords
    let lavel1: String
    let level2: String
    
    enum CodingKeys: String, CodingKey {
        case coords
        case lavel1 = "lavel_1"
        case level2 = "level_2"
    }
}

struct DNetResEtherCoords: Codable {
    let lat: Double
    let lng: Double

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}

struct DNetResPagination: Codable {
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

struct DNetResEtherOrderService: Codable {
    let cost: Int
    let costType: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}


