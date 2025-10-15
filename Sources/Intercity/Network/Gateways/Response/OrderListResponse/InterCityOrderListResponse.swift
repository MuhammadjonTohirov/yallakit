//
//  Result.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 14/10/25.
//

import SwiftUI

struct InterCityOrderListResponse: Codable {
    let list: [InterCityOrderListResult]?
    let pagination: Pagination?
}

// MARK: - List
struct InterCityOrderListResult: Codable {
    let brandID: Int?
    let brand, brandService, address: Address?
    let createdAt: Int?
    let service, sourceType, status: String?
    let useTheBonus, fixedPrice: Bool?
    let id: Int?
    let paymentType: String?
    let routes: [Route]?
    let executorCoverBonus: ExecutorCoverBonus?,
    let executorBonus: ExecutorBonus? ,
    let executorCompensation: ExecutorCompensation?
    let directionToClient: ExecutorDirectionToClient?,
    let tariff: Tariff?
    let intercityOrder: IntercityOrder?
    let counterparty: Bool?
    let tripDate: String?

    enum CodingKeys: String, CodingKey {
        case brandID = "brand_id"
        case brand
        case brandService = "brand_service"
        case address
        case createdAt = "created_at"
        case service
        case sourceType = "source_type"
        case status
        case useTheBonus = "use_the_bonus"
        case fixedPrice = "fixed_price"
        case id
        case paymentType = "payment_type"
        case routes
        case executorCoverBonus = "executor_cover_bonus"
        case executorBonus = "executor_bonus"
        case directionToClient = "direction_to_client"
        case executorCompensation = "executor_compensation"
        case tariff
        case intercityOrder = "intercity_order"
        case counterparty
        case tripDate = "trip_date"
    }
}
struct ExecutorCoverBonus: Codable {
    let approxPrice: Double?
    let calculationType: String?
    let cost: Double?
    let status: Bool?
    let duration: Double?
    let distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case approxPrice = "approx_price"
        case calculationType = "calculation_type"
        case cost
        case status
        case duration
        case distance
    }
}
struct ExecutorCompensation: Codable {
    let minCost: Double?
    let minKm: Double?
    let cost: Double?
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm = "min_km"
        case cost
    }
}
struct ExecutorBonus: Codable {
    let cost: Double?
    let minCost: Double?
    let minKm: Double?
    let status: Bool?

    enum CodingKeys: String, CodingKey {
        case cost
        case minCost = "min_cost"
        case minKm = "min_km"
        case status
    }
}
struct ExecutorDirectionToClient: Codable {
    let distance: Double?
    let duration: Double?
    let mapType: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case mapType = "map_type"
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let name: String?
}

// MARK: - IntercityOrder
struct IntercityOrder: Codable {
    let startHour, endHour: String?
    let scheduleID, tariffID?,
    let totalPrice: Double?
    let isBooked, isPostal: Bool?

    enum CodingKeys: String, CodingKey {
        case startHour = "start_hour"
        case endHour = "end_hour"
        case scheduleID = "schedule_id"
        case tariffID = "tariff_id"
        case totalPrice = "total_price"
        case isBooked = "is_booked"
        case isPostal = "is_postal"
    }
}

// MARK: - Route
struct Route: Codable {
    let coords: DirectionToClient?
    let level1, level2: String?
    let index: Int?

    enum CodingKeys: String, CodingKey {
        case coords
        case level1 = "level_1"
        case level2 = "level_2"
        case index
    }
}

// MARK: - Tariff
struct Tariff: Codable {
    let id: Int?
    let name: String?
    let tariffCategoryID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case tariffCategoryID = "tariff_category_id"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let count, currentPage, lastPage, perPage: Int?
    let total, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
    }
}
