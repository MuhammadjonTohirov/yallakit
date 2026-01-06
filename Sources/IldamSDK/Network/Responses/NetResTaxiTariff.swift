//
//  NetResTaxiTariff.swift
//  Ildam
//
//  Created by applebro on 20/12/23.
//

import Foundation
import Core

// MARK: - TaxiTariffs
struct NetResTaxiTariffList: NetResBody {
    let tariffs: [NetResTaxiTariff]?
    let working: NetResTaxiWorking?
    
    enum CodingKeys: String, CodingKey {
        case tariffs = "tariff"
        case working
    }
}

struct NetResTaxiWorking: Codable {
    let brandId: Int?
    let isWorking: Bool?
    let text: String?
    let addressId: Int64?
    
    enum CodingKeys: String, CodingKey {
        case brandId = "brand_id"
        case isWorking = "is_working"
        case text
        case addressId = "address_id"
    }
}

// MARK: - Tariff
struct NetResTaxiTariff: Codable {
    let id: Int
    let name: String?
    let description: String?
    let photo, icon: String?
    let cost, cityKMCost: Float?
    let includedKM: Double?
    let fixedType: Bool?
    let fixedPrice: Float?
    let secondAddress: Bool?
    let index: Int?
    var services: [NetResTaxiTariffService]?
    var category: NetResTaxiTariffCategory?
    var award: NetResTaxiTariffAward?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, photo, icon, cost
        case cityKMCost = "city_km_cost"
        case includedKM = "included_km"
        case fixedType = "fixed_type"
        case fixedPrice = "fixed_price"
        case secondAddress = "second_address"
        case index, services, award
    }
}

struct NetResTaxiTariffAward: Codable {
    let cashOrPercentage: String
    let minKm: Float
    let minPrice: Float
    let value: Float
    
    enum CodingKeys: String, CodingKey {
        case cashOrPercentage = "cash_or_percentage"
        case minKm = "min_km"
        case minPrice = "min_price"
        case value
    }
}

struct NetResTaxiTariffCategory: Codable {
    let id: Int
    let name: String
}

// MARK: - Service
struct NetResTaxiTariffService: Codable, Identifiable {
    var id: Int
    let cost: Float?
    let name, costType: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case cost, name
        case id
        case costType = "cost_type"
        case icon
    }
    
    var isSelected: Bool = false
}
