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
    public let service: String
    public let sourceType: String
    public let status: String
    public let statusTime: [OrderStatusTime]?
    public let toPhone: String
    public let useTheBonus: Bool
    
    init(from network: DNetResDriverOrderShowResponse) {
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
        self.executorBonus = ExecutorBonus(from: DNetResDriverOrderShowResponse.ExecutorBonus(
            cost: network.executorBonus.cost,
            minCost: network.executorBonus.minCost,
            minKm: network.executorBonus.minKm,
            status: network.executorBonus.status))
        self.executorCompensation = ExecutorCompensation(
            minCost: network.executorCompensation?.minCost ?? 0,
            minKm: network.executorCompensation?.minKm ?? 0,
            cost: network.executorCompensation?.cost ?? 0
        )
        self.executorCoverBonus = ExecutorCoverBonus(from: network.executorCoverBonus)
        self.fixedPrice = network.fixedPrice
        self.roadDirection = OrderRoadDirection(from: network.roadDirection)
        self.routes = network.routes.map { OrderRoute(from: $0) }
        self.reason = network.reason
        self.toPhone = network.toPhone
        self.useTheBonus = network.useTheBonus
        self.sendingTime = network.sendingTime
        self.addressId = network.addressId
        self.sourceType = network.sourceType
        self.dontCallMe = network.dontCallMe
        self.statusTime = network.statusTime
        self.service = network.service
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
        service: String,
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
    
    init(from network: DNetResDriverOrderShowResponse.DNetResOrderBrand) {
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
    public let services: [DNetResOrderService]?
    public let tariffName: String
    
    init(from network: DNetResDriverOrderShowResponse.OrderDetail) {
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
        self.services = network.services
        self.tariffName = network.tariffName
    }
}
public struct DirectionToClient {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    init(from network: DNetResDriverOrderShowResponse.DirectionToClient) {
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
    
    init(from network: DNetResDriverOrderShowResponse.ExecutorBonus) {
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
    
    init(from network: DNetResDriverOrderShowResponse.ExecutorCoverBonus) {
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
    
    init(from network: DNetResDriverOrderShowResponse.OrderRoadDirection) {
        self.distance = network.distance
        self.duration = network.duration
    }
}
public struct OrderRoute {
    public let coords: Coordinate
    public let lavel1: String
    public let level2: String
    
    init(from network: DNetResDriverOrderShowResponse.OrderRoute) {
        self.coords = Coordinate(from: network.coords)
        self.lavel1 = network.lavel1
        self.level2 = network.level2
    }
    
    public struct Coordinate {
        public let lat: Double
        public let lng: Double
        
        init(from network: DNetResDriverOrderShowResponse.OrderRoute.Coords) {
            self.lat = network.lat
            self.lng = network.lng
        }
    }
    
}
public struct DNetResOrderService: Codable {
    public let cost: Int
    public let costType, name: String
    
    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}
public struct OrderCancelReason: Codable {
    public let id: Int
    public let name: String
}
public struct OrderStatusTime: Codable {
    public var status: String?
    public let time: Int?
}
public struct OrderEnergy: Codable {
    public let cancel: Int
    public let km: Int
    public let minus: Int
    public let plus: Int
}
public struct ExecutorCompensation: Codable {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case minCost = "min_cost"
        case minKm  = "min_km"
        case cost
    }
}

