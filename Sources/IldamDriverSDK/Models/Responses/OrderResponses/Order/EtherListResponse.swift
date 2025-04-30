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
                EtherListOrderService(
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
    init(from network: DNetResEtherOrderBrand) {
        self.addressName = network.addressName
        self.name = network.name
        self.serviceName = network.serviceName
    }
}

public struct EtherListDetail: Codable {
    public let approxTotalPrice: Double?
    public let cost: Double?
    public let modifPrice: Double?
    public let modifPriceEvent: String?
    public let services: [EtherListOrderService]?
    public let tariffName: String
    
    public init(approxTotalPrice: Double?, cost: Double?, modifPrice: Double?, modifPriceEvent: String?, services: [EtherListOrderService]?, tariffName: String) {
        self.approxTotalPrice = approxTotalPrice
        self.cost = cost
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
    init(from network: DNetResEtherOrderDetail) {
        self.approxTotalPrice = network.approxTotalPrice
        self.cost = network.cost
        self.modifPrice = network.modifPrice
        self.modifPriceEvent = network.modifPriceEvent
        self.services = network.services?.map {
            EtherListOrderService(from: $0)
        }
        self.tariffName = network.tariffName
    }
}
public struct EtherListDirectionToClient: Codable {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
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
    
    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
    
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
    
    public init(calculationType: String, cost: Int, status: Bool) {
        self.calculationType = calculationType
        self.cost = cost
        self.status = status
    }
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
    
    public init(cost: Int, minCost: Int, minKm: Int, status: Bool) {
        self.cost = cost
        self.minCost = minCost
        self.minKm = minKm
        self.status = status
    }
    init(from network: DNetResEtherExecutorBonus) {
        self.cost = network.cost
        self.minCost = network.minCost
        self.minKm = network.minKm
        self.status = network.status
    }
}

public struct EtherListOrderService: Codable {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(from network: DNetResEtherOrderService) {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
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
    
    init(from network: DNetResEtherOrderRoute) {
        self.coords = EtherListCoords(lat: network.coords.lat, lng: network.coords.lng)
        self.lavel1 = network.lavel1
        self.level2 = network.level2
    }
}

public struct EtherListCoords: Codable {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    init(from network: DNetResEtherCoords) {
        self.lat = network.lat
        self.lng = network.lng
        
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
    
    init(network: DNetResPagination) {
        self.count = network.count ?? 0
        self.currentPage = network.currentPage ?? 0
        self.lastPage = network.lastPage ?? 0
        self.perPage = network.perPage ?? 0
        self.total = network.total ?? 0
        self.totalPages = network.totalPages ?? 0
    }
}
