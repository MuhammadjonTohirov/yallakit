//
//  OrderTariffConfigurationResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import NetworkLayer
import Core

struct DNetOrderTariffConfigResponse: DNetResBody {
    let bonusAmount: Int
    let cost: Int
    let executorCoverBonus: DNetOrderTariffConfigExecutorCoverBonus
    let id: Int
    let inCity: DNetOrderTariffConfigCity?
    let outCity: DNetOrderTariffConfigCity?
    let service: [DNetOrderTariffConfigService]?
    let taxiTariff: DNetOrderTariffConfigTaxiTariff
    let useTheBonus: Bool
    
    enum CodingKeys: String, CodingKey {
        case bonusAmount = "bonus_amount"
        case cost
        case executorCoverBonus = "executor_cover_bonus"
        case id
        case inCity = "in_city"
        case outCity = "out_city"
        case service
        case taxiTariff = "taxi_tariff"
        case useTheBonus = "use_the_bonus"
    }
    
    struct DNetOrderTariffConfigExecutorCoverBonus: Codable {
        let bonusCalcType: String
        let byDistance: [DNetResPricingRuleValue]
        let byDuration: [DNetResPricingRuleValue]
        let calculationType: String
        let roundingCost: Int
        let roundingType: String
        
        enum CodingKeys: String, CodingKey {
            case bonusCalcType = "bonus_calc_type"
            case byDistance = "by_distance"
            case byDuration = "by_duration"
            case calculationType = "calculation_type"
            case roundingCost = "rounding_cost"
            case roundingType = "rounding_type"
        }
    }
    
    struct DNetOrderTariffConfigTaxiTariff: Codable {
        let calculationType: String
        let cityKmCost: Int
        let cityMinuteCost: Int
        let complexCalculation: Bool
        let `default`: Bool
        let fixedType: Bool
        let freeWaitingTime: Int
        let id: Int
        let includedKm: Int
        let includedMinute: Int
        let insideCityKm: [DNetResPricingRuleValue]
        let insideCityMinute: [DNetResPricingRuleValue]
        let minimalCityCost: Int
        let minimalOutCityCost: Int
        let name: String
        let outCityFreeWaitingTime: Int
        let outCityKm: [DNetResPricingRuleValue]
        let outCityKmCost: Int
        let outCityMinute: [DNetResPricingRuleValue]
        let outCityMinuteCost: Int
        let outCityWaitingMinuteCost: Int
        let outIncludedKm: Int
        let outIncludedMinute: Int
        let recountDistance: Int
        let roundingCost: Int
        let roundingType: String
        let tariffCategoryId: Int
        let taximeterDistance: Int
        let taximeterTime: Int
        let waitingMinuteCost: Int
        
        enum CodingKeys: String, CodingKey {
            case calculationType = "calculation_type"
            case cityKmCost = "city_km_cost"
            case cityMinuteCost = "city_minute_cost"
            case complexCalculation = "complex_calculation"
            case `default` = "default"
            case fixedType = "fixed_type"
            case freeWaitingTime = "free_waiting_time"
            case id
            case includedKm = "included_km"
            case includedMinute = "included_minute"
            case insideCityKm = "inside_city_km"
            case insideCityMinute = "inside_city_minute"
            case minimalCityCost = "minimal_city_cost"
            case minimalOutCityCost = "minimal_out_city_cost"
            case name
            case outCityFreeWaitingTime = "out_city_free_waiting_time"
            case outCityKm = "out_city_km"
            case outCityKmCost = "out_city_km_cost"
            case outCityMinute = "out_city_minute"
            case outCityMinuteCost = "out_city_minute_cost"
            case outCityWaitingMinuteCost = "out_city_waiting_minute_cost"
            case outIncludedKm = "out_included_km"
            case outIncludedMinute = "out_included_minute"
            case recountDistance = "recount_distance"
            case roundingCost = "rounding_cost"
            case roundingType = "rounding_type"
            case tariffCategoryId = "tariff_category_id"
            case taximeterDistance = "taximeter_distance"
            case taximeterTime = "taximeter_time"
            case waitingMinuteCost = "waiting_minute_cost"
        }
    }
    
    struct DNetResPricingRuleValue: Codable {
        let cost: Int
        let value: Int
    }
    
    struct DNetOrderTariffConfigCity: Codable {
        let distance: Double
        let duration: String
        let waitPrice: Double
        let waitTime: String
        
        enum CodingKeys: String, CodingKey {
            case distance
            case duration
            case waitPrice = "wait_price"
            case waitTime = "wait_time"
        }
    }
}
struct DNetOrderTariffConfigService: Codable {
    let cost: Int
    let costType, name: String
    
    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}
struct DNetOrderCancelReason: Codable {
    let id: Int
    let name: String
}
struct DNetOrderStatusTime: Codable {
    var status: String?
    let time: Int?
}
struct DNetOrderEnergy: Codable {
    let cancel: Int
    let km: Int
    let minus: Int
    let plus: Int
}
struct DNetExecutorCompensation: Codable {
    let minCost: Double
    let minKm: Double
    let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm  = "min_km"
        case cost
    }
}
