//
//  TaxiTariffList.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation
import Core

// MARK: - TaxiTariffs
public struct TaxiTariffList {
    public let tariffs: [TaxiTariff]?
    public let working: TaxiWorkingItem?
    
    public init(tariffs: [TaxiTariff]?, working: TaxiWorkingItem?) {
        self.tariffs = tariffs
        self.working = working
    }
}

public struct TaxiWorkingItem: Sendable {
    public var brandId: Int?
    public var isWorking: Bool
    public var text: String?
    public var addressId: Int64?
    
    public init(brandId: Int, isWorking: Bool, text: String, addressId: Int64?) {
        self.brandId = brandId
        self.isWorking = isWorking
        self.text = text
        self.addressId = addressId
    }
    
    init?(_ res: NetResTaxiWorking?) {
        guard let res else { return nil }
        
        self.brandId = res.brandId
        self.isWorking = res.isWorking ?? false
        self.text = res.text
        self.addressId = res.addressId
    }
}

// MARK: - Tariff
public struct TaxiTariff: Sendable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let photo, icon: String?
    public let cost, cityKMCost: Float?
    public let includedKM: Double?
    public let fixedType: Bool?
    public let fixedPrice: Float?
    public let secondAddress: Bool?
    public let index: Int?
    public var services: [TaxiTariffService]?
    public var category: TaxiTariffCategory?
    public var award: TaxiTariffAward?
    
    public init(id: Int, name: String?, description: String?, photo: String?, icon: String?, cost: Float?, cityKMCost: Float?, includedKM: Double?, fixedType: Bool?, fixedPrice: Float?, secondAddress: Bool?, index: Int?, services: [TaxiTariffService]? = nil, category: TaxiTariffCategory? = nil, award: TaxiTariffAward? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
        self.icon = icon
        self.cost = cost
        self.cityKMCost = cityKMCost
        self.includedKM = includedKM
        self.fixedType = fixedType
        self.fixedPrice = fixedPrice
        self.secondAddress = secondAddress
        self.index = index
        self.services = services
        self.category = category
        self.award = award
    }
}

public struct TaxiTariffAward: Sendable {
    public let cashOrPercentage: String
    public let minKm: Float
    public let minPrice: Float
    public let value: Float
    
    public init(cashOrPercentage: String, minKm: Float, minPrice: Float, value: Float) {
        self.cashOrPercentage = cashOrPercentage
        self.minKm = minKm
        self.minPrice = minPrice
        self.value = value
    }
    
    init?(res: NetResTaxiTariffAward?) {
        guard let res else { return nil }
        
        self.cashOrPercentage = res.cashOrPercentage
        self.minKm = res.minKm
        self.minPrice = res.minPrice
        self.value = res.value
    }
}

public struct TaxiTariffCategory: Sendable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Service
public struct TaxiTariffService: Identifiable, Sendable {
    public var id: Int
    public let cost: Float?
    public let name, costType: String?
    public var icon: String?
    public var isSelected: Bool = false
    
    public init(id: Int, cost: Float?, name: String?, costType: String?, icon: String?, isSelected: Bool) {
        self.id = id
        self.cost = cost
        self.name = name
        self.costType = costType
        self.isSelected = isSelected
        self.icon = icon
    }
}

extension TaxiTariffList {
    init?(res: NetResTaxiTariffList?) {
        guard let res = res else { return nil }
        self.tariffs = res.tariffs?.compactMap(TaxiTariff.init)
        self.working = .init(res.working)
    }
}

extension TaxiTariff {
    init?(res: NetResTaxiTariff?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.name = res.name
        self.description = res.description
        self.photo = res.photo
        self.icon = res.icon
        self.cost = res.cost
        self.cityKMCost = res.cityKMCost
        self.includedKM = res.includedKM
        self.fixedType = res.fixedType
        self.fixedPrice = res.fixedPrice
        self.secondAddress = res.secondAddress
        self.index = res.index
        self.category = res.category.flatMap(TaxiTariffCategory.init) ?? nil
        self.services = res.services?.compactMap(TaxiTariffService.init) ?? []
        self.award = .init(res: res.award)
    }
}

extension TaxiTariffCategory {
    init?(res: NetResTaxiTariffCategory?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.name = res.name
    }
}

extension TaxiTariffService {
    init?(res: NetResTaxiTariffService?) {
        guard let res = res else { return nil }
        self.cost = res.cost
        self.id = res.id
        self.name = res.name
        self.costType = res.costType
        self.isSelected = false
        self.icon = res.icon
    }
}


extension TaxiTariff: Equatable {}
extension TaxiTariff: Identifiable, Hashable {
    public static func == (lhs: TaxiTariff, rhs: TaxiTariff) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

