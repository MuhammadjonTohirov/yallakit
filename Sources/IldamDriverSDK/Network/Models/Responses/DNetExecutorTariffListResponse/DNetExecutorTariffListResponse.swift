//
//  DNetExecutorTariffListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

struct DNetExecutorTariffListResponse: DNetResBody {
    let executorTariffs: [DNetExecutorTariff]
    let tariffList: [DNetTariffListItem]

    enum CodingKeys: String, CodingKey {
        case executorTariffs = "executor_tariffs"
        case tariffList = "tariff_list"
    }
}

struct DNetExecutorTariff: Codable {
    let id: Int
    let `default`: Bool
    let brandName: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case `default`
        case brandName = "brand_name"
        case name
    }
}

struct DNetTariffListItem: Codable {
    let id: Int
    let name: String
    let brandName: String
    let freeWaitingTime: Int
    let tariffCategoryId: Int
    let waitingMinuteCost: String
    let minimalCityCost: String
    let cityKmCost: String
    let minimalOutCityCost: String
    let outCityKmCost: String
    let includedKm: String
    let cityMinuteCost: String
    let `default`: Bool
    let changeExecutor: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case brandName = "brand_name"
        case freeWaitingTime = "free_waiting_time"
        case tariffCategoryId = "tariff_category_id"
        case waitingMinuteCost = "waiting_minute_cost"
        case minimalCityCost = "minimal_city_cost"
        case cityKmCost = "city_km_cost"
        case minimalOutCityCost = "minimal_out_city_cost"
        case outCityKmCost = "out_city_km_cost"
        case includedKm = "included_km"
        case cityMinuteCost = "city_minute_cost"
        case `default`
        case changeExecutor = "change_executor"
    }
}

