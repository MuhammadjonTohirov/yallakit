//
//  ExecutorTariffListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

public struct ExecutorTariffListResponse {
    public let executorTariffs: [ExecutorTariff]
    public let tariffList: [TariffListItem]

    public init(executorTariffs: [ExecutorTariff], tariffList: [TariffListItem]) {
        self.executorTariffs = executorTariffs
        self.tariffList = tariffList
    }

    init(from network: DNetExecutorTariffListResponse) {
        self.executorTariffs = network.executorTariffs.map(ExecutorTariff.init)
        self.tariffList = network.tariffList.map(TariffListItem.init)
    }
}

public struct ExecutorTariff {
    public let id: Int
    public let isDefault: Bool
    public let brandName: String
    public let name: String

    public init(id: Int, isDefault: Bool, brandName: String, name: String) {
        self.id = id
        self.isDefault = isDefault
        self.brandName = brandName
        self.name = name
    }
    init(from network: DNetExecutorTariff) {
        self.id = network.id
        self.isDefault = network.default
        self.brandName = network.brandName
        self.name = network.name
    }
}

public struct TariffListItem {
    public let id: Int
    public let name: String
    public let brandName: String
    public let freeWaitingTime: Int
    public let tariffCategoryId: Int
    public let waitingMinuteCost: String
    public let minimalCityCost: String
    public let cityKmCost: String
    public let minimalOutCityCost: String
    public let outCityKmCost: String
    public let includedKm: String
    public let cityMinuteCost: String
    public let isDefault: Bool
    public let changeExecutor: Bool

    public init(id: Int, name: String, brandName: String, freeWaitingTime: Int, tariffCategoryId: Int, waitingMinuteCost: String, minimalCityCost: String, cityKmCost: String, minimalOutCityCost: String, outCityKmCost: String, includedKm: String, cityMinuteCost: String, isDefault: Bool, changeExecutor: Bool) {
        self.id = id
        self.name = name
        self.brandName = brandName
        self.freeWaitingTime = freeWaitingTime
        self.tariffCategoryId = tariffCategoryId
        self.waitingMinuteCost = waitingMinuteCost
        self.minimalCityCost = minimalCityCost
        self.cityKmCost = cityKmCost
        self.minimalOutCityCost = minimalOutCityCost
        self.outCityKmCost = outCityKmCost
        self.includedKm = includedKm
        self.cityMinuteCost = cityMinuteCost
        self.isDefault = isDefault
        self.changeExecutor = changeExecutor
    }
    
    init(from network: DNetTariffListItem) {
        self.id = network.id
        self.name = network.name
        self.brandName = network.brandName
        self.freeWaitingTime = network.freeWaitingTime
        self.tariffCategoryId = network.tariffCategoryId
        self.waitingMinuteCost = network.waitingMinuteCost
        self.minimalCityCost = network.minimalCityCost
        self.cityKmCost = network.cityKmCost
        self.minimalOutCityCost = network.minimalOutCityCost
        self.outCityKmCost = network.outCityKmCost
        self.includedKm = network.includedKm
        self.cityMinuteCost = network.cityMinuteCost
        self.isDefault = network.default
        self.changeExecutor = network.changeExecutor
    }
}
