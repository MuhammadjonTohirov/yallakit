//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 26/04/25.
//

import Foundation
import NetworkLayer
import Core

public struct EtherListResponse: DNetResBody {
    public var list: [EtherList]?
    public let pagination: Pagination
}

public struct EtherList: Codable {
    public let addressId: Int
    public let brand: EtherListBrand
    public let counterparty: Bool?
    public let createdAt: Int
    public let detail: EtherListDetail?
    public let directionToClient: EtherListDirectionToClient?
    public let executorBonus: EtherListExecutorBonus
    public let executorCompensation: EtherListExecutorCompensation?
    public let executorCoverBonus: EtherListExecutorCoverBonus?
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let routes: [EtherListOrderRoute]
    public let service: String?
    public let status: String?
    public let useTheBonus: Bool
    
    init(from network: DNetResEtherList) {
        self.addressId = network.addressId
        self.brand = EtherListBrand(
            addressName: network.brand.addressName,
            name: network.brand.name,
            serviceName: network.brand.serviceName
        )
        self.counterparty = network.counterparty
        self.createdAt = network.createdAt
        self.detail = EtherListDetail(
            approxTotalPrice: network.detail.approxTotalPrice,
            cost: network.detail.cost,
            modifPrice: network.detail.modifPrice,
            modifPriceEvent: network.detail.modifPriceEvent,
            services: network.detail.services?.map { service in
                OrderService(
                    cost: service.cost,
                    costType: service.costType,
                    name: service.name
                )
            },
            tariffName: network.detail.tariffName
        )
        self.directionToClient = EtherListDirectionToClient(
            from: DNetResEtherDirectionToClient(
                distance: network.directionToClient.distance,
                duration: network.directionToClient.duration,
                mapType: network.directionToClient.mapType)
        )
        self.executorBonus = EtherListExecutorBonus(from: DNetResEtherExecutorBonus(
            cost: network.executorBonus.cost,
            minCost: network.executorBonus.minCost,
            minKm: network.executorBonus.minKm,
            status: network.executorBonus.status))
        self.executorCompensation = network.executorCompensation.map { compensation in
            EtherListExecutorCompensation(from: DNetResEtherExecutorCompensation(
                minCost: compensation.minCost,
                minKm: compensation.minKm,
                cost: compensation.cost))
        }
        
        self.executorCoverBonus = EtherListExecutorCoverBonus(from: DNetResEtherExecutorCoverBonus(
            calculationType: network.executorCoverBonus.calculationType,
            cost: network.executorCoverBonus.cost,
            status: network.executorCoverBonus.status))
        
        self.fixedPrice = network.fixedPrice
        self.id = network.id
        self.paymentType = network.paymentType
        self.routes = network.routes.map { route in
            EtherListOrderRoute(
                coords: EtherListCoords(
                    lat: route.coords.lat,
                    lng: route.coords.lng
                ),
                lavel1: route.lavel1,
                level2: route.level2
            )
        }
        self.service = network.service
        self.status = network.status
        self.useTheBonus = network.useTheBonus
    }
    
    
    public init(
        addressId: Int,
        brand: EtherListBrand,
        counterparty: Bool?,
        createdAt: Int,
        detail: EtherListDetail?,
        directionToClient: EtherListDirectionToClient?,
        executorBonus: EtherListExecutorBonus,
        executorCompensation: EtherListExecutorCompensation?,
        executorCoverBonus: EtherListExecutorCoverBonus?,
        fixedPrice: Bool,
        id: Int,
        paymentType: String,
        routes: [EtherListOrderRoute],
        service: String?,
        status: String?,
        sourceType: String?,
        useTheBonus: Bool) {
            self.addressId = addressId
            self.brand = brand
            self.counterparty = counterparty
            self.createdAt = createdAt
            self.detail = detail
            self.directionToClient = directionToClient
            self.executorBonus = executorBonus
            self.executorCompensation = executorCompensation
            self.executorCoverBonus = executorCoverBonus
            self.fixedPrice = fixedPrice
            self.id = id
            self.paymentType = paymentType
            self.routes = routes
            self.service = service
            self.status = status
            self.useTheBonus = useTheBonus
        }
}

public struct EtherListBrand: Codable {
    public let addressName: String
    public let name: String
    public let serviceName: String
    
    public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
}

public struct EtherListDetail: Codable {
    public let approxTotalPrice: Double?
    public let cost: Double?
    public let modifPrice: Double?
    public let modifPriceEvent: String?
    public let services: [OrderService]?
    public let tariffName: String
    
    public init(approxTotalPrice: Double?, cost: Double?, modifPrice: Double?, modifPriceEvent: String?, services: [OrderService]?, tariffName: String) {
        self.approxTotalPrice = approxTotalPrice
        self.cost = cost
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
}
public struct EtherListDirectionToClient: Codable {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    init(from network: DNetResEtherDirectionToClient) {
        self.distance = network.distance
        self.duration = network.duration
        self.mapType = network.mapType
    }
}
public struct EtherListExecutorCompensation: Codable {
    let minCost: Double
    let minKm: Double
    let cost: Double
    
    init(from network: DNetResEtherExecutorCompensation) {
        self.minCost = network.minCost
        self.minKm = network.minKm
        self.cost = network.cost
    }
}
public struct EtherListExecutorCoverBonus: Codable {
    public let calculationType: String
    public let cost: Int
    public let status: Bool
 
    init(from network: DNetResEtherExecutorCoverBonus) {
        self.calculationType = network.calculationType
        self.cost = network.cost
        self.status = network.status
    }
}

public struct EtherListExecutorBonus: Codable {
    public let cost: Int
    public let minCost: Int
    public let minKm: Int
    public let status: Bool
    
    init(from network: DNetResEtherExecutorBonus) {
        self.cost = network.cost
        self.minCost = network.minCost
        self.minKm = network.minKm
        self.status = network.status
    }
}

public struct OrderService: Codable {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
}

public struct EtherListOrderRoute: Codable {
    public let coords: EtherListCoords
    public let lavel1: String
    public let level2: String
    
    public init(coords: EtherListCoords, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }
}

public struct EtherListCoords: Codable {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

public struct Pagination: Codable {
    public let count: Int
    public let currentPage: Int
    public let lastPage: Int
    public let perPage: Int
    public let total: Int
    public let totalPages: Int
    
    public init(count: Int, currentPage: Int, lastPage: Int, perPage: Int, total: Int, totalPages: Int) {
        self.count = count
        self.currentPage = currentPage
        self.lastPage = lastPage
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
    }
}
