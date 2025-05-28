//
//  OrderSentToExecutorResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//

import Foundation


public struct OrderSentToExecutorResponse {
    public let addressID: Int
    public let brand: OrderSentToExecutorBrand
    public let clientPhone: String
    public let coefficient: Double
    public let createdAt: Double
    public let detail: OrderSentToExecutorDetail
    public let directionToClient: OrderSentToExecutorDirectionToClient
    public let dontCallMe: Bool
    public let energy: OrderSentToExecutorEnergy
    public let executorCompensation: OrderSentToExecutorExecutorCompensation
    public let executorCoverBonus: OrderSentToExecutorExecutorCoverBonus
    public let executorBonus: OrderSentToExecutorExecutorBonus
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let reason: OrderSentToExecutorReason
    public let roadDirection: OrderSentToExecutorDirectionToClient
    public let routes: [OrderSentToExecutorRoute]
    public let sendingTime: Int
    public let service: String
    public let sourceType: String
    public let status: String
    public let statusTime: [OrderSentToExecutorStatusTime]
    public let toPhone: String
    public let useTheBonus: Bool
    
    public init(
        addressID: Int,
        brand: OrderSentToExecutorBrand,
        clientPhone: String,
        coefficient: Double,
        createdAt: Double,
        detail: OrderSentToExecutorDetail,
        directionToClient: OrderSentToExecutorDirectionToClient,
        dontCallMe: Bool,
        energy: OrderSentToExecutorEnergy,
        executorCompensation: OrderSentToExecutorExecutorCompensation,
        executorCoverBonus: OrderSentToExecutorExecutorCoverBonus,
        executorBonus: OrderSentToExecutorExecutorBonus,
        fixedPrice: Bool,
        id: Int,
        paymentType: String,
        reason: OrderSentToExecutorReason,
        roadDirection: OrderSentToExecutorDirectionToClient,
        routes: [OrderSentToExecutorRoute],
        sendingTime: Int,
        service: String,
        sourceType: String,
        status: String,
        statusTime: [OrderSentToExecutorStatusTime],
        toPhone: String,
        useTheBonus: Bool
    ) {
        self.addressID = addressID
        self.brand = brand
        self.clientPhone = clientPhone
        self.coefficient = coefficient
        self.createdAt = createdAt
        self.detail = detail
        self.directionToClient = directionToClient
        self.dontCallMe = dontCallMe
        self.energy = energy
        self.executorCompensation = executorCompensation
        self.executorCoverBonus = executorCoverBonus
        self.executorBonus = executorBonus
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
    
    init(from network: DNetOrderSentToExecutorResult) {
        self.addressID = network.addressID ?? 0
        self.brand = OrderSentToExecutorBrand(from: network.brand)
        self.clientPhone = network.clientPhone ?? ""
        self.coefficient = network.coefficient ?? 1.0
        self.createdAt = network.createdAt ?? 0.0
        self.detail = OrderSentToExecutorDetail(from: network.detail)
        self.directionToClient = OrderSentToExecutorDirectionToClient(from: network.directionToClient)
        self.dontCallMe = network.dontCallMe ?? false
        self.energy = OrderSentToExecutorEnergy(from: network.energy)
        self.executorCompensation = OrderSentToExecutorExecutorCompensation(from: network.executorCompensation)
        self.executorCoverBonus = OrderSentToExecutorExecutorCoverBonus(from: network.executorCoverBonus)
        self.executorBonus = OrderSentToExecutorExecutorBonus(from: network.executorBonus)
        self.fixedPrice = network.fixedPrice ?? false
        self.id = network.id ?? 0
        self.paymentType = network.paymentType ?? ""
        self.reason = OrderSentToExecutorReason(from: network.reason)
        self.roadDirection = OrderSentToExecutorDirectionToClient(from: network.roadDirection)
        self.routes = (network.routes ?? []).map(OrderSentToExecutorRoute.init(from:))
        self.sendingTime = network.sendingTime ?? 0
        self.service = network.service ?? ""
        self.sourceType = network.sourceType ?? ""
        self.status = network.status ?? ""
        self.statusTime = (network.statusTime ?? []).map(OrderSentToExecutorStatusTime.init(from:))
        self.toPhone = network.toPhone ?? ""
        self.useTheBonus = network.useTheBonus ?? false
    }
}

public struct OrderSentToExecutorBrand {
    public let addressName: String
    public let name: String
    public let serviceName: String
    
    public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
    
    init(from network: DNetOrderSentToExecutorBrand?) {
        self.addressName = network?.addressName ?? ""
        self.name = network?.name ?? ""
        self.serviceName = network?.serviceName ?? ""
    }
}

public struct OrderSentToExecutorDetail {
    public let bonusAmount: Int
    public let cost: Int
    public let modifPrice: Int
    public let modifPriceEvent: String
    public let services: [OrderSentToExecutorService]
    public let tariffName: String
    
    public init(bonusAmount: Int, cost: Int, modifPrice: Int, modifPriceEvent: String, services: [OrderSentToExecutorService], tariffName: String) {
        self.bonusAmount = bonusAmount
        self.cost = cost
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
    
    init(from network: DNetOrderSentToExecutorDetail?) {
        self.bonusAmount = network?.bonusAmount ?? 0
        self.cost = network?.cost ?? 0
        self.modifPrice = network?.modifPrice ?? 0
        self.modifPriceEvent = network?.modifPriceEvent ?? ""
        self.services = (network?.services ?? []).map(OrderSentToExecutorService.init(from:))
        self.tariffName = network?.tariffName ?? ""
    }
}

public struct OrderSentToExecutorService {
    public let cost: Int
    public let costType: String
    public let name: String
    
    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(from network: DNetOrderSentToExecutorService) {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
    }
}

public struct OrderSentToExecutorReason {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetOrderSentToExecutorReason?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct OrderSentToExecutorDirectionToClient {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
    
    init(from network: DNetOrderSentToExecutorDirectionToClient?) {
        self.distance = network?.distance ?? 0.0
        self.duration = network?.duration ?? 0.0
        self.mapType = network?.mapType ?? ""
    }
}

public struct OrderSentToExecutorExecutorCompensation {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double
    
    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
    
    init(from network: DNetOrderSentToExecutorCompensation?) {
        self.minCost = network?.minCost ?? 0.0
        self.minKm = network?.minKm ?? 0.0
        self.cost = network?.cost ?? 0.0
    }
}

public struct OrderSentToExecutorExecutorCoverBonus {
    public let approxPrice: Int
    public let calculationType: String
    public let cost: Int
    public let status: Bool
    
    public init(approxPrice: Int, calculationType: String, cost: Int, status: Bool) {
        self.approxPrice = approxPrice
        self.calculationType = calculationType
        self.cost = cost
        self.status = status
    }
    
    init(from network: DNetOrderSentToExecutorCoverBonus?) {
        self.approxPrice = network?.approxPrice ?? 0
        self.calculationType = network?.calculationType ?? ""
        self.cost = network?.cost ?? 0
        self.status = network?.status ?? false
    }
}

public struct OrderSentToExecutorExecutorBonus {
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
    
    init(from network: DNetOrderSentToExecutorBonus?) {
        self.cost = network?.cost ?? 0
        self.minCost = network?.minCost ?? 0
        self.minKm = network?.minKm ?? 0
        self.status = network?.status ?? false
    }
}

public struct OrderSentToExecutorRoute {
    public let coords: OrderSentToExecutorCoords
    public let lavel1: String
    public let level2: String
    
    public init(coords: OrderSentToExecutorCoords, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }
    
    init(from network: DNetOrderSentToExecutorRoute) {
        self.coords = OrderSentToExecutorCoords(from: network.coords)
        self.lavel1 = network.lavel1
        self.level2 = network.level2
    }
}

public struct OrderSentToExecutorCoords {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(from network: DNetOrderSentToExecutorCoords) {
        self.lat = network.lat
        self.lng = network.lng
    }
}

public struct OrderSentToExecutorEnergy {
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
    
    init(from network: DNetOrderSentToExecutorEnergy?) {
        self.cancel = network?.cancel ?? 0
        self.km = network?.km ?? 0
        self.minus = network?.minus ?? 0
        self.plus = network?.plus ?? 0
    }
}

public struct OrderSentToExecutorStatusTime {
    public let status: String
    public let time: Int
    
    public init(status: String, time: Int) {
        self.status = status
        self.time = time
    }
    
    init(from network: DNetOrderSentToExecutorStatusTime) {
        self.status = network.status ?? ""
        self.time = network.time ?? 0
    }
}
