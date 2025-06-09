//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 26/04/25.
//

import Foundation
import NetworkLayer
import Core

public struct OrderListResponse: DNetResBody,Sendable {
    public var list: [EtherList]
    public let pagination: Pagination
    
    public init(list: [EtherList], pagination: Pagination) {
        self.list = list
        self.pagination = pagination
    }
    
    init?(from network: DNetResEtherResponse?) {
        guard let network = network else { return nil }
        
        self.list = network.list?.compactMap { EtherList(from: $0) } ?? []
        
        let networkPagination = network.pagination ?? DNetResPagination(
            count: 0,
            currentPage: 0,
            lastPage: 0,
            perPage: 0,
            total: 0,
            totalPages: 0
        )
        self.pagination = Pagination(
            total: networkPagination.total ?? 0,
            count: networkPagination.count ?? 0,
            perPage: "\(networkPagination.perPage ?? 0)",
            currentPage: networkPagination.currentPage ?? 0,
            totalPages: networkPagination.totalPages ?? 0,
            lastPage: networkPagination.lastPage ?? 0
        )
    }
}

public struct EtherList: Codable, Sendable {
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
    
    init?(from network: DNetResEtherList?) {
        guard let network = network else { return nil }
        
        self.addressId = network.addressId ?? 0
        self.brand = EtherListBrand(
            addressName: network.brand?.addressName ?? "",
            name: network.brand?.name ?? "",
            serviceName: network.brand?.serviceName ?? ""
        )
        self.counterparty = network.counterparty
        self.createdAt = network.createdAt ?? 0
        self.detail = network.detail.map { detail in
            EtherListDetail(
                approxTotalPrice: detail.approxTotalPrice ?? 0,
                cost: detail.cost ?? 0,
                modifPrice: detail.modifPrice ?? 0,
                modifPriceEvent: detail.modifPriceEvent ?? "",
                services: detail.services?.map { service in
                    EtherListOrderService(
                        cost: service.cost ?? 0,
                        costType: service.costType ?? "",
                        name: service.name ?? ""
                    )
                } ?? [],
                tariffName: detail.tariffName ?? ""
            )
        }
        self.directionToClient = network.directionToClient.map { direction in
            EtherListDirectionToClient(
                distance: direction.distance ?? 0,
                duration: direction.duration ?? 0,
                mapType: direction.mapType ?? ""
            )
        }
        self.executorBonus = EtherListExecutorBonus(
            cost: network.executorBonus?.cost ?? 0,
            minCost: network.executorBonus?.minCost ?? 0,
            minKm: network.executorBonus?.minKm ?? 0,
            status: network.executorBonus?.status ?? false
        )
        self.executorCompensation = network.executorCompensation.map { compensation in
            EtherListExecutorCompensation(
                minCost: compensation.minCost ?? 0,
                minKm: compensation.minKm ?? 0,
                cost: compensation.cost ?? 0
            )
        }
        self.executorCoverBonus = network.executorCoverBonus.map { coverBonus in
            EtherListExecutorCoverBonus(
                calculationType: coverBonus.calculationType ?? "",
                cost: coverBonus.cost ?? 0,
                status: coverBonus.status ?? false
            )
        }
        self.fixedPrice = network.fixedPrice ?? false
        self.id = network.id ?? 0
        self.paymentType = network.paymentType ?? ""
        self.routes = network.routes?.map { route in
            EtherListOrderRoute(
                coords: EtherListCoords(
                    lat: route.coords?.lat ?? 0,
                    lng: route.coords?.lng ?? 0
                ),
                lavel1: route.lavel1 ?? "",
                level2: route.level2 ?? ""
            )
        } ?? []
        self.service = network.service
        self.status = network.status
        self.useTheBonus = network.useTheBonus ?? false
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
        useTheBonus: Bool
    ) {
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

public struct EtherListBrand: Codable, Sendable {
    
    public let addressName: String
    public let name: String
    public let serviceName: String
    
    public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
    
    init(from network: DNetResEtherOrderBrand) {
        self.addressName = network.addressName ?? ""
        self.name = network.name ?? ""
        self.serviceName = network.serviceName ?? ""
    }
}

public struct EtherListDetail: Codable, Sendable {
    public let approxTotalPrice: Double?
    public let cost: Double?
    public let modifPrice: Double?
    public let modifPriceEvent: String?
    public let services: [EtherListOrderService]?
    public let tariffName: String?
    
    public init(
        approxTotalPrice: Double,
        cost: Double,
        modifPrice: Double,
        modifPriceEvent: String,
        services: [EtherListOrderService],
        tariffName: String
    ) {
        self.approxTotalPrice = approxTotalPrice
        self.cost = cost
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
    
    init(from network: DNetResEtherOrderDetail?) {
        self.approxTotalPrice = network?.approxTotalPrice ?? 0
        self.cost = network?.cost ?? 0
        self.modifPrice = network?.modifPrice ?? 0
        self.modifPriceEvent = network?.modifPriceEvent ?? ""
        self.services = network?.services?.compactMap {
            EtherListOrderService(
                cost: $0.cost ?? 0,
                costType: $0.costType ?? "",
                name: $0.name ?? ""
            )
        } ?? []
        self.tariffName = network?.tariffName ?? ""
    }
}

public struct EtherListDirectionToClient: Codable, Sendable {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
    
    init(from network: DNetResEtherDirectionToClient) {
        self.distance = network.distance ?? 0
        self.duration = network.duration ?? 0
        self.mapType = network.mapType ?? ""
    }
}

public struct EtherListExecutorCompensation: Codable, Sendable {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double
    
    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
    
    init?(from network: DNetResEtherExecutorCompensation?) {
        guard
            let minCost = network?.minCost,
            let minKm = network?.minKm,
            let cost = network?.cost
                
        else {return nil}
        
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
}
public struct EtherListExecutorCoverBonus: Codable, Sendable {
    public let calculationType: String
    public let cost: Int
    public let status: Bool
    
    public init(calculationType: String, cost: Int, status: Bool) {
        self.calculationType = calculationType
        self.cost = cost
        self.status = status
    }
    init?(from network: DNetResEtherExecutorCoverBonus?) {
        guard
            let calculationType = network?.calculationType,
            let cost = network?.cost,
            let status = network?.status else {return nil}
        
        self.calculationType = calculationType
        self.cost = cost
        self.status = status
    }
}

public struct EtherListExecutorBonus: Codable, Sendable {
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
    init?(from network: DNetResEtherExecutorBonus?) {
        guard
            let cost = network?.cost,
            let minCost = network?.minCost,
            let minKm = network?.minKm,
            let status = network?.status else {return nil}
        
        self.cost = cost
        self.minCost = minCost
        self.minKm = minKm
        self.status = status
    }
}

public struct EtherListOrderService: Codable, Sendable {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init?(from network: DNetResEtherOrderService?) {
        guard
            let cost = network?.cost,
            let costType = network?.costType,
            let name = network?.name else {return nil}
        
        self.cost = cost
        self.costType = costType
        self.name = name
    }
}

public struct EtherListOrderRoute: Codable, Sendable {
    public let coords: EtherListCoords
    public let lavel1: String
    public let level2: String
    
    public init(coords: EtherListCoords, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }
    
    init?(from network: DNetResEtherOrderRoute?) {
        guard let coords = network?.coords,
              let lavel1 = network?.lavel1,
              let level2 = network?.level2 else {return nil}
        
        self.coords = EtherListCoords(lat: coords.lat ?? 0, lng: coords.lng ?? 0)
        self.lavel1 = lavel1
        self.level2 = level2
    }
}

public struct EtherListCoords: Codable, Sendable {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    init?(from network: DNetResEtherCoords?) {
        guard
            let lat = network?.lat,
            let lng = network?.lng else {return nil}
        
        self.lat = lat
        self.lng = lng
        
    }
}

public struct Pagination: Codable, Sendable {
    public let total: Int
    public let count: Int
    public let perPage: String
    public let currentPage: Int
    public let totalPages: Int
    public let lastPage: Int
    
    public init(total: Int, count: Int, perPage: String, currentPage: Int, totalPages: Int, lastPage: Int) {
        self.total = total
        self.count = count
        self.perPage = perPage
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.lastPage = lastPage
    }
    
    init?(from network: DNetResPagination?) {
        self.total = network?.total ?? 0
        self.count = network?.count  ?? 0
        self.perPage = "\(network?.perPage ?? 0)"
        self.currentPage = network?.currentPage  ?? 0
        self.totalPages = network?.totalPages  ?? 0
        self.lastPage = network?.lastPage ?? 0
    }
}

