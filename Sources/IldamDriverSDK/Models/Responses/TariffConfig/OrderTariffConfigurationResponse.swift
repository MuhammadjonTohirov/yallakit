//
//  DriverOrderTariffConfigurationResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import NetworkLayer
import SwiftUI

public struct OrderTariffConfigurationResponse {
    public let bonusAmount: Int
    public let cost: Int
    public let executorCoverBonus: ExecutorTariffCoverBonus
    public let id: Int
    public let inCity: City?
    public let outCity: City?
    public let service: [OrderTariffService]?
    public let taxiTariff: TaxiTariff
    public let useTheBonus: Bool
    
    public init(
        bonusAmount: Int,
        cost: Int,
        executorCoverBonus: ExecutorTariffCoverBonus,
        id: Int,
        inCity: City?,
        outCity: City?,
        service: [OrderTariffService]?,
        taxiTariff: TaxiTariff,
        useTheBonus: Bool
    ) {
        self.bonusAmount = bonusAmount
        self.cost = cost
        self.executorCoverBonus = executorCoverBonus
        self.id = id
        self.inCity = inCity
        self.outCity = outCity
        self.service = service
        self.taxiTariff = taxiTariff
        self.useTheBonus = useTheBonus
    }
    
    init(from network: DNetOrderTariffConfigResponse) {
        self.bonusAmount = network.bonusAmount
        self.cost = network.cost
        self.executorCoverBonus = ExecutorTariffCoverBonus(from: DNetOrderTariffConfigResponse.DNetOrderTariffConfigExecutorCoverBonus(
            bonusCalcType: network.executorCoverBonus.bonusCalcType,
            byDistance: network.executorCoverBonus.byDistance,
            byDuration: network.executorCoverBonus.byDuration,
            calculationType: network.executorCoverBonus.calculationType ,
            roundingCost: network.executorCoverBonus.roundingCost,
            roundingType: network.executorCoverBonus.roundingType
        ))
        
        self.id = network.id
        self.inCity = network.inCity.map { City(from: $0) }
        self.outCity = network.outCity.map { City(from: $0) }
        self.service = network.service?.map { OrderTariffService(from: $0) }
        self.taxiTariff = TaxiTariff(from: network.taxiTariff)
        self.useTheBonus = network.useTheBonus
    }
}
public struct ExecutorTariffCoverBonus {
    public let bonusCalcType: String
    public let byDistance: [PricingRuleValue]
    public let byDuration: [PricingRuleValue]
    public let calculationType: String
    public let roundingCost: Int
    public let roundingType: String
    
    public init(bonusCalcType: String, byDistance: [PricingRuleValue], byDuration: [PricingRuleValue], calculationType: String, roundingCost: Int, roundingType: String) {
        self.bonusCalcType = bonusCalcType
        self.byDistance = byDistance
        self.byDuration = byDuration
        self.calculationType = calculationType
        self.roundingCost = roundingCost
        self.roundingType = roundingType
    }
    
    init(from network: DNetOrderTariffConfigResponse.DNetOrderTariffConfigExecutorCoverBonus) {
        self.bonusCalcType = network.bonusCalcType
        self.byDistance = network.byDistance.map { PricingRuleValue(from: $0) }
        self.byDuration = network.byDuration.map { PricingRuleValue(from: $0) }
        self.calculationType = network.calculationType
        self.roundingCost = network.roundingCost
        self.roundingType = network.roundingType
    }
}
public struct PricingRuleValue {
    public let cost: Int
    public let value: Int
    
    public init(cost: Int, value: Int) {
        self.cost = cost
        self.value = value
    }
    init(from network: DNetOrderTariffConfigResponse.DNetResPricingRuleValue) {
        self.cost = network.cost
        self.value = network.value
    }
}
public struct City {
    public let distance: Double
    public let duration: String
    public let waitPrice: Double
    public let waitTime: String
    
    public init(distance: Double, duration: String, waitPrice: Double, waitTime: String) {
        self.distance = distance
        self.duration = duration
        self.waitPrice = waitPrice
        self.waitTime = waitTime
    }
    
    init(from network: DNetOrderTariffConfigResponse.DNetOrderTariffConfigCity) {
        self.distance = network.distance
        self.duration = network.duration
        self.waitPrice = network.waitPrice
        self.waitTime = network.waitTime
    }
}
public struct TaxiTariff {
    public let calculationType: String
    public let cityKmCost: Int
    public let cityMinuteCost: Int
    public let complexCalculation: Bool
    public let isDefault: Bool
    public let fixedType: Bool
    public let freeWaitingTime: Int
    public let id: Int
    public let includedKm: Int
    public let includedMinute: Int
    public let insideCityKm: [PricingRuleValue]
    public let insideCityMinute: [PricingRuleValue]
    public let minimalCityCost: Int
    public let minimalOutCityCost: Int
    public let name: String
    public let outCityFreeWaitingTime: Int
    public let outCityKm: [PricingRuleValue]
    public let outCityKmCost: Int
    public let outCityMinute: [PricingRuleValue]
    public let outCityMinuteCost: Int
    public let outCityWaitingMinuteCost: Int
    public let outIncludedKm: Int
    public let outIncludedMinute: Int
    public let recountDistance: Int
    public let roundingCost: Int
    public let roundingType: String
    public let tariffCategoryId: Int
    public let taximeterDistance: Int
    public let taximeterTime: Int
    public let waitingMinuteCost: Int
    
    public init(calculationType: String, cityKmCost: Int, cityMinuteCost: Int, complexCalculation: Bool, isDefault: Bool, fixedType: Bool, freeWaitingTime: Int, id: Int, includedKm: Int, includedMinute: Int, insideCityKm: [PricingRuleValue], insideCityMinute: [PricingRuleValue], minimalCityCost: Int, minimalOutCityCost: Int, name: String, outCityFreeWaitingTime: Int, outCityKm: [PricingRuleValue], outCityKmCost: Int, outCityMinute: [PricingRuleValue], outCityMinuteCost: Int, outCityWaitingMinuteCost: Int, outIncludedKm: Int, outIncludedMinute: Int, recountDistance: Int, roundingCost: Int, roundingType: String, tariffCategoryId: Int, taximeterDistance: Int, taximeterTime: Int, waitingMinuteCost: Int) {
        self.calculationType = calculationType
        self.cityKmCost = cityKmCost
        self.cityMinuteCost = cityMinuteCost
        self.complexCalculation = complexCalculation
        self.isDefault = isDefault
        self.fixedType = fixedType
        self.freeWaitingTime = freeWaitingTime
        self.id = id
        self.includedKm = includedKm
        self.includedMinute = includedMinute
        self.insideCityKm = insideCityKm
        self.insideCityMinute = insideCityMinute
        self.minimalCityCost = minimalCityCost
        self.minimalOutCityCost = minimalOutCityCost
        self.name = name
        self.outCityFreeWaitingTime = outCityFreeWaitingTime
        self.outCityKm = outCityKm
        self.outCityKmCost = outCityKmCost
        self.outCityMinute = outCityMinute
        self.outCityMinuteCost = outCityMinuteCost
        self.outCityWaitingMinuteCost = outCityWaitingMinuteCost
        self.outIncludedKm = outIncludedKm
        self.outIncludedMinute = outIncludedMinute
        self.recountDistance = recountDistance
        self.roundingCost = roundingCost
        self.roundingType = roundingType
        self.tariffCategoryId = tariffCategoryId
        self.taximeterDistance = taximeterDistance
        self.taximeterTime = taximeterTime
        self.waitingMinuteCost = waitingMinuteCost
    }
    init(from network: DNetOrderTariffConfigResponse.DNetOrderTariffConfigTaxiTariff) {
        self.calculationType = network.calculationType
        self.cityKmCost = network.cityKmCost
        self.cityMinuteCost = network.cityMinuteCost
        self.complexCalculation = network.complexCalculation
        self.isDefault = network.default
        self.fixedType = network.fixedType
        self.freeWaitingTime = network.freeWaitingTime
        self.id = network.id
        self.includedKm = network.includedKm
        self.includedMinute = network.includedMinute
        self.insideCityKm = network.insideCityKm.map { PricingRuleValue(from: $0) }
        self.insideCityMinute = network.insideCityMinute.map { PricingRuleValue(from: $0) }
        self.minimalCityCost = network.minimalCityCost
        self.minimalOutCityCost = network.minimalOutCityCost
        self.name = network.name
        self.outCityFreeWaitingTime = network.outCityFreeWaitingTime
        self.outCityKm = network.outCityKm.map { PricingRuleValue(from: $0) }
        self.outCityKmCost = network.outCityKmCost
        self.outCityMinute = network.outCityMinute.map { PricingRuleValue(from: $0) }
        self.outCityMinuteCost = network.outCityMinuteCost
        self.outCityWaitingMinuteCost = network.outCityWaitingMinuteCost
        self.outIncludedKm = network.outIncludedKm
        self.outIncludedMinute = network.outIncludedMinute
        self.recountDistance = network.recountDistance
        self.roundingCost = network.roundingCost
        self.roundingType = network.roundingType
        self.tariffCategoryId = network.tariffCategoryId
        self.taximeterDistance = network.taximeterDistance
        self.taximeterTime = network.taximeterTime
        self.waitingMinuteCost = network.waitingMinuteCost
    }
}
public struct ExecutorOrderTariffService {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(from network: DNetOrderTariffConfigService) {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
    }
}
public struct OrderTariffService: Codable {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(from network: DNetOrderTariffConfigService) {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
    }
}
