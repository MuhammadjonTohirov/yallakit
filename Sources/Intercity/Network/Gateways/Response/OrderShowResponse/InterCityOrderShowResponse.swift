//
//  InterCityOrderShowResponse.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 14/10/25.
//

import SwiftUI

struct InterCityOrderShowResponse: Codable {
    
    let brandID: Int?
    let brand, brandService, address: Address?
    let createdAt: Int?
    let service, sourceType, status: String?
    let useTheBonus, fixedPrice: Bool?
    let id: Int?
    let paymentType: String?
    let routes: [Route]?
    let tariff: Tariff?
    let taxiOrder: TaxiOrder?
    let intercityOrder: IntercityOrder?
    let counterparty: Bool?
    let client: Client?
    let phone: String?
    let clientID: Int?
    let tripDate, comment: String?

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
        case routes, tariff
        case taxiOrder = "taxi_order"
        case intercityOrder = "intercity_order"
        case counterparty, client, phone
        case clientID = "client_id"
        case tripDate = "trip_date"
        case comment
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Client
struct Client: Codable {
    let id: Int?
    let phone, surName, givenNames, fatherName: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id, phone
        case surName = "sur_name"
        case givenNames = "given_names"
        case fatherName = "father_name"
        case gender
    }
}

// MARK: - IntercityOrder
struct IntercityOrder: Codable {
    let startHour, endHour: String?
    let scheduleID: Int?
    let totalPrice: Double?
    let isBooked: Bool?
    let seatLayouts: [SeatLayout]?
    let isPostal: Bool?

    enum CodingKeys: String, CodingKey {
        case startHour = "start_hour"
        case endHour = "end_hour"
        case scheduleID = "schedule_id"
        case totalPrice = "total_price"
        case isBooked = "is_booked"
        case seatLayouts = "seat_layouts"
        case isPostal = "is_postal"
    }
}

// MARK: - SeatLayout
struct SeatLayout: Codable {
    let tariffSeatPriceID: Int?
    let gender, slug: String?
    let index, seatLayoutID: Int?
    let price: Double?

    enum CodingKeys: String, CodingKey {
        case tariffSeatPriceID = "tariff_seat_price_id"
        case gender, slug, index
        case seatLayoutID = "seat_layout_id"
        case price
    }
}

// MARK: - Route
struct Route: Codable {
    let coords: TaxiOrder?
    let level1, level2: String?
    let index: Int?

    enum CodingKeys: String, CodingKey {
        case coords
        case level1 = "level_1"
        case level2 = "level_2"
        case index
    }
}

// MARK: - TaxiOrder
struct TaxiOrder: Codable {
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
