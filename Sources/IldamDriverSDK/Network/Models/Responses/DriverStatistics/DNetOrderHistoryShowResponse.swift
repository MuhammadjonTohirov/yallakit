//
//  DNetOrderHistoryShowResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

struct DNetOrderHistoryShowResponse: DNetResBody {
    let id: Int
    let addressId: Int
    let service: String
    let status: String
    let paymentType: String
    let fixedPrice: Bool
    let reason: DNetOrderHistoryReason?
    let routes: [DNetOrderRoute]
    let totalPrice: Double
    let comission: Double
    let energy: Double
    let counterparty: Bool
    let clientPhone: String
    let track: [DNetOrderHistoryTripTrack]?
    let brandName: String
    let createdAt: Int
    let complateTime: Int
    let comment: String?
    let tariff: String
    let distance: String
    let services: [DNetOrderService]
    let modifPrice: DNetOrderModifPrice
    let executorBonus: Double
    let compensationBonus: Double
    let coverBonus: Double
    let clientBonus: Double

    enum CodingKeys: String, CodingKey {
        case id
        case addressId = "address_id"
        case service
        case status
        case paymentType = "payment_type"
        case fixedPrice = "fixed_price"
        case reason
        case routes
        case totalPrice = "total_price"
        case comission
        case energy
        case counterparty
        case clientPhone = "client_phone"
        case track
        case brandName = "brand_name"
        case createdAt = "created_at"
        case complateTime = "complate_time"
        case comment
        case tariff
        case distance
        case services
        case modifPrice = "modif_price"
        case executorBonus = "executor_bonus"
        case compensationBonus = "compensation_bonus"
        case coverBonus = "cover_bonus"
        case clientBonus = "client_bonus"
    }
}

struct DNetOrderRoute: Codable {
    let index: Int
    let name: String
    let lat: String
    let lng: String
}

struct DNetOrderService: Codable {
    let id: Int
    let name: String
    let uz: String
    let ru: String
}

struct DNetOrderModifPrice: Codable {
    let modifPrice: String
    let modifPriceEvent: String?

    enum CodingKeys: String, CodingKey {
        case modifPrice = "modif_price"
        case modifPriceEvent = "modif_price_event"
    }
}
struct DNetOrderHistoryReason: Codable {
    let id: Int
    let name: String
}
struct DNetOrderHistoryTripTrack: Codable {
    let heading: Double
    let lat: Double
    let lng: Double
    let speed: Double
    let status: String?
}
