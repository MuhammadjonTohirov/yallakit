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
    public let tariffs: [TaxiTariff]
    
    public init(tariffs: [TaxiTariff]) {
        self.tariffs = tariffs
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
    
    public init(id: Int, name: String?, description: String?, photo: String?, icon: String?, cost: Float?, cityKMCost: Float?, includedKM: Double?, fixedType: Bool?, fixedPrice: Float?, secondAddress: Bool?, index: Int?, services: [TaxiTariffService]? = nil, category: TaxiTariffCategory? = nil) {
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
    public let cost: Int
    public let name, costType: String
    public var isSelected: Bool = false
    
    public init(id: Int, cost: Int, name: String, costType: String, isSelected: Bool) {
        self.id = id
        self.cost = cost
        self.name = name
        self.costType = costType
        self.isSelected = isSelected
    }
}

extension TaxiTariffList {
    init?(res: NetResTaxiTariffList?) {
        guard let res = res else { return nil }
        self.tariffs = res.tariffs.compactMap(TaxiTariff.init)
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

