//
//  DriverOrderShowResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import NetworkLayer
import Core

public struct OrderShowResponse {
    public let addressId: Int
    public let brand: OrderBrand
    public let clientPhone: String
    public let coefficient: Double
    public let createdAt: Int
    public let detail: OrderDetail
    public let directionToClient: DirectionToClient
    public let dontCallMe: Bool
    public let energy: OrderEnergy
    public let executorBonus: ExecutorBonus
    public let executorCompensation: ExecutorCompensation?
    public let executorCoverBonus: ExecutorCoverBonus
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let reason: OrderCancelReason?
    public let roadDirection: OrderRoadDirection
    public let routes: [OrderRoute]
    public let sendingTime: Int
    public let service: OrderService
    public let sourceType: String
    public let status: String
    public let statusTime: [OrderStatusTime]?
    public let toPhone: String
    public let useTheBonus: Bool
    
    init(from network: DNetOrderShowResponse) {
        self.id = network.id
        self.clientPhone = network.clientPhone
        self.status = network.status
        self.paymentType = network.paymentType
        self.coefficient = network.coefficient
        self.createdAt = network.createdAt
        self.brand = OrderBrand(from: network.brand)
        self.detail = OrderDetail(from: network.detail)
        self.directionToClient = DirectionToClient(from: network.directionToClient)
        self.energy = OrderEnergy(
            cancel: network.energy.cancel,
            km: network.energy.km,
            minus: network.energy.minus,
            plus: network.energy.plus)
        self.executorBonus = ExecutorBonus(
            cost: network.executorBonus.cost,
            minCost: network.executorBonus.minCost,
            minKm: network.executorBonus.minKm,
            status: network.executorBonus.status)
        self.executorCompensation = ExecutorCompensation(
            minCost: network.executorCompensation?.minCost ?? 0,
            minKm: network.executorCompensation?.minKm ?? 0,
            cost: network.executorCompensation?.cost ?? 0
        )
        self.executorCoverBonus = ExecutorCoverBonus(from: network.executorCoverBonus)
        self.fixedPrice = network.fixedPrice
        self.roadDirection = OrderRoadDirection(from: network.roadDirection)
        self.routes      = network.routes.map { OrderRoute(from: $0) }
        self.reason      = network.reason.map {OrderCancelReason(network: $0)}
        self.toPhone     = network.toPhone
        self.useTheBonus = network.useTheBonus
        self.sendingTime = network.sendingTime
        self.addressId   = network.addressId
        self.sourceType  = network.sourceType
        self.dontCallMe  = network.dontCallMe
        self.statusTime  = network.statusTime?.map { OrderStatusTime(network: $0) }
        self.service = OrderService(
            cost: network.service.cost,
            costType: network.service.costType,
            name: network.service.name)
    }
    public init(
        addressId: Int,
        brand: OrderBrand,
        clientPhone: String,
        coefficient: Double,
        createdAt: Int,
        detail: OrderDetail,
        directionToClient: DirectionToClient,
        dontCallMe: Bool,
        energy: OrderEnergy,
        executorBonus: ExecutorBonus,
        executorCompensation: ExecutorCompensation?,
        executorCoverBonus: ExecutorCoverBonus,
        fixedPrice: Bool,
        id: Int,
        paymentType: String,
        reason: OrderCancelReason?,
        roadDirection: OrderRoadDirection,
        routes: [OrderRoute],
        sendingTime: Int,
        service: OrderService,
        sourceType: String,
        status: String,
        statusTime: [OrderStatusTime]?,
        toPhone: String,
        useTheBonus: Bool
    ) {
        self.addressId = addressId
        self.brand = brand
        self.clientPhone = clientPhone
        self.coefficient = coefficient
        self.createdAt = createdAt
        self.detail = detail
        self.directionToClient = directionToClient
        self.dontCallMe = dontCallMe
        self.energy = energy
        self.executorBonus = executorBonus
        self.executorCompensation = executorCompensation
        self.executorCoverBonus = executorCoverBonus
        self.fixedPrice = fixedPrice
        self.id = id
        self.paymentType = paymentType
        self.reason = reason
        self.roadDirection = roadDirection
        self.routes = routes
        self.sendingTime = sendingTime
        self.service = service
        self.sourceType = sourceType
        self.status = status
        self.statusTime = statusTime
        self.toPhone = toPhone
        self.useTheBonus = useTheBonus
    }
}
public struct OrderBrand: Codable {
    public let addressName: String
    public let name: String
    public let serviceName: String
    
    public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
    init(from network: DNetOrderShowResponse.DNetOrderShowBrand) {
        self.addressName = network.addressName
        self.name = network.name
        self.serviceName = network.serviceName
    }
}
public struct OrderDetail: Codable {
    public let approxDistance: Double
    public let approxDuration: Double
    public let approxTotalPrice: Int
    public let bonusAmount: Int
    public let comment: String
    public let cost: Int
    public let distance: Int
    public let duration: String
    public let modifPrice: Int
    public let modifPriceEvent: String
    public let services: [OrderService]?
    public let tariffName: String
    
    public init(approxDistance: Double, approxDuration: Double, approxTotalPrice: Int, bonusAmount: Int, comment: String, cost: Int, distance: Int, duration: String, modifPrice: Int, modifPriceEvent: String, services: [OrderService]?, tariffName: String) {
        self.approxDistance = approxDistance
        self.approxDuration = approxDuration
        self.approxTotalPrice = approxTotalPrice
        self.bonusAmount = bonusAmount
        self.comment = comment
        self.cost = cost
        self.distance = distance
        self.duration = duration
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
    init(from network: DNetOrderShowResponse.DNetOrderShowDetail) {
        self.approxDistance = network.approxDistance
        self.approxDuration = network.approxDuration
        self.approxTotalPrice = network.approxTotalPrice
        self.bonusAmount = network.bonusAmount
        self.comment = network.comment
        self.cost = network.cost
        self.distance = network.distance
        self.duration = network.duration
        self.modifPrice = network.modifPrice
        self.modifPriceEvent = network.modifPriceEvent
        self.services = network.services?.map { OrderService(network: $0) }
        self.tariffName = network.tariffName
    }
}
public struct DirectionToClient {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
    init(from network: DNetOrderShowResponse.DNetOrderShowDirectionToClient) {
        self.distance = network.distance
        self.duration = network.duration
        self.mapType = network.mapType
    }
}
public struct ExecutorBonus {
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
    
    init(from network: DNetOrderShowResponse.DNetOrderShowExecutorBonus) {
        self.cost = network.cost
        self.minCost = network.minCost
        self.minKm = network.minKm
        self.status = network.status
    }
}
public struct ExecutorCoverBonus {
    public let approxPrice: Int
    public let calculationType: String
    public let cost: Int
    public let distance: Int
    public let duration: Int
    public let status: Bool
    
    public init(approxPrice: Int, calculationType: String, cost: Int, distance: Int, duration: Int, status: Bool) {
        self.approxPrice = approxPrice
        self.calculationType = calculationType
        self.cost = cost
        self.distance = distance
        self.duration = duration
        self.status = status
    }
    init(from network: DNetOrderShowResponse.DNetOrderShowExecutorCoverBonus) {
        self.approxPrice = network.approxPrice
        self.calculationType = network.calculationType
        self.cost = network.cost
        self.distance = network.distance
        self.duration = network.duration
        self.status = network.status
    }
}
public struct OrderRoadDirection {
    public let distance: Int
    public let duration: Int
    
    public init(distance: Int, duration: Int) {
        self.distance = distance
        self.duration = duration
    }
    init(from network: DNetOrderShowResponse.DNetOrderRoadDirection) {
        self.distance = network.distance
        self.duration = network.duration
    }
}
public struct OrderRoute {
    public let coords: Coordinate
    public let lavel1: String
    public let level2: String
    
    public init(coords: Coordinate, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }
    init(from network: DNetOrderShowResponse.DNetOrderRoute) {
        self.coords = Coordinate(from: network.coords)
        self.lavel1 = network.lavel1
        self.level2 = network.level2
    }
    
    public struct Coordinate {
        public let lat: Double
        public let lng: Double
        
        public init(lat: Double, lng: Double) {
            self.lat = lat
            self.lng = lng
        }
        init(from network: DNetOrderShowResponse.DNetOrderRoute.Coords) {
            self.lat = network.lat
            self.lng = network.lng
        }
    }
}
public struct OrderEnergy: Codable {
    public let cancel: Int
    public let km: Int
    public let minus: Int
    public let plus: Int
    
    public init(cancel: Int, km: Int, minus: Int, plus: Int) {
        self.cancel = cancel
        self.km = km
        self.minus = minus
        self.plus = plus
    }
    
    init(network: DNetOrderShowResponse.DNetOrderShowEnergy) {
        self.cancel = network.cancel
        self.km = network.km
        self.minus = network.minus
        self.plus = network.plus
    }
}
public struct ExecutorCompensation: Codable {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double
    
    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
    init(network: DNetOrderShowResponse.DNetOrderShowExecutorCompensation) {
        self.minKm = network.minKm
        self.minCost = network.minCost
        self.cost = network.cost
    }
}
public struct OrderCancelReason: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    init(network:DNetOrderShowResponse.DNetOrderShowCancelReason) {
        self.id = network.id
        self.name = network.name
    }
}
public struct OrderStatusTime: Codable {
    public var status: String?
    public let time: Int?
    
    public init(status: String? = nil, time: Int?) {
        self.status = status
        self.time = time
    }
    
    init(network: DNetOrderShowResponse.DNetOrderShowStatusTime )  {
         
        self.status = network.status
        self.time = network.time
    }
}
public struct OrderService: Codable {
    public let cost: Int
    public let costType, name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(network: DNetOrderShowService)  {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
    }
}
