//
//  OrderUpdateSocketResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//

import Foundation

public struct OrderUpdateSocketResponse {
    public let addressID: Int
    public let brand: OrderUpdateBrand
    public let clientPhone: String
    public let coefficient: Double
    public let createdAt: Double
    public let detail: OrderUpdateDetail
    public let directionToClient: OrderUpdateDirectionToClient
    public let dontCallMe: Bool
    public let energy: OrderUpdateEnergy
    public let executorCompensation: OrderUpdateExecutorCompensation
    public let executorCoverBonus: OrderUpdateExecutorCoverBonus
    public let executorBonus: OrderUpdateExecutorBonus
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let reason: OrderUpdateReason
    public let roadDirection: OrderUpdateDirectionToClient
    public let routes: [OrderUpdateRoute]
    public let sendingTime: Int
    public let service: String
    public let sourceType: String
    public let status: String
    public let statusTime: [OrderUpdateStatusTime]
    public let toPhone: String
    public let useTheBonus: Bool

    public init(
        addressID: Int,
        brand: OrderUpdateBrand,
        clientPhone: String,
        coefficient: Double,
        createdAt: Double,
        detail: OrderUpdateDetail,
        directionToClient: OrderUpdateDirectionToClient,
        dontCallMe: Bool,
        energy: OrderUpdateEnergy,
        executorCompensation: OrderUpdateExecutorCompensation,
        executorCoverBonus: OrderUpdateExecutorCoverBonus,
        executorBonus: OrderUpdateExecutorBonus,
        fixedPrice: Bool,
        id: Int,
        paymentType: String,
        reason: OrderUpdateReason,
        roadDirection: OrderUpdateDirectionToClient,
        routes: [OrderUpdateRoute],
        sendingTime: Int,
        service: String,
        sourceType: String,
        status: String,
        statusTime: [OrderUpdateStatusTime],
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

    init(from network: DNetOrderUpdateResult) {
        self.addressID = network.addressID ?? 0
        self.brand = OrderUpdateBrand(from: network.brand)
        self.clientPhone = network.clientPhone ?? ""
        self.coefficient = network.coefficient ?? 1.0
        self.createdAt = network.createdAt ?? 0.0
        self.detail = OrderUpdateDetail(from: network.detail)
        self.directionToClient = OrderUpdateDirectionToClient(from: network.directionToClient)
        self.dontCallMe = network.dontCallMe ?? false
        self.energy = OrderUpdateEnergy(from: network.energy)
        self.executorCompensation = OrderUpdateExecutorCompensation(from: network.executorCompensation)
        self.executorCoverBonus = OrderUpdateExecutorCoverBonus(from: network.executorCoverBonus)
        self.executorBonus = OrderUpdateExecutorBonus(from: network.executorBonus)
        self.fixedPrice = network.fixedPrice ?? false
        self.id = network.id ?? 0
        self.paymentType = network.paymentType ?? ""
        self.reason = OrderUpdateReason(from: network.reason)
        self.roadDirection = OrderUpdateDirectionToClient(from: network.roadDirection)
        self.routes = (network.routes ?? []).map(OrderUpdateRoute.init(from:))
        self.sendingTime = network.sendingTime ?? 0
        self.service = network.service ?? ""
        self.sourceType = network.sourceType ?? ""
        self.status = network.status ?? ""
        self.statusTime = (network.statusTime ?? []).map(OrderUpdateStatusTime.init(from:))
        self.toPhone = network.toPhone ?? ""
        self.useTheBonus = network.useTheBonus ?? false
    }
}

public struct OrderUpdateBrand {
    public let addressName: String
    public let name: String
    public let serviceName: String

    public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
    
    init(from network: DNetOrderUpdateBrand?) {
        self.addressName = network?.addressName ?? ""
        self.name = network?.name ?? ""
        self.serviceName = network?.serviceName ?? ""
    }
}

public struct OrderUpdateDetail {
    public let bonusAmount: Int
    public let cost: Int
    public let modifPrice: Int
    public let modifPriceEvent: String
    public let services: [OrderUpdateService]
    public let tariffName: String
    
    public  init(bonusAmount: Int, cost: Int, modifPrice: Int, modifPriceEvent: String, services: [OrderUpdateService], tariffName: String) {
        self.bonusAmount = bonusAmount
        self.cost = cost
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.services = services
        self.tariffName = tariffName
    }
 
    init(from network: DNetOrderUpdateDetail?) {
        self.bonusAmount = network?.bonusAmount ?? 0
        self.cost = network?.cost ?? 0
        self.modifPrice = network?.modifPrice ?? 0
        self.modifPriceEvent = network?.modifPriceEvent ?? ""
        self.services = (network?.services ?? []).map { OrderUpdateService(from: $0) }
        self.tariffName = network?.tariffName ?? ""
    }

}

public struct OrderUpdateService {
    public let cost: Int
    public let costType: String
    public let name: String

    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }

    init(from network: DNetOrderUpdateService) {
        self.cost = network.cost
        self.costType = network.costType
        self.name = network.name
    }
}


public struct OrderUpdateDirectionToClient {
    public let distance: Double
    public let duration: Double
    public let mapType: String

    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
    init(from network: DNetOrderUpdateDirectionToClient?) {
        self.distance = network?.distance ?? 0.0
        self.duration = network?.duration ?? 0.0
        self.mapType = network?.mapType ?? ""
    }
}

public struct OrderUpdateEnergy {
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
    
    init(from network: DNetOrderUpdateEnergy?) {
        self.cancel = network?.cancel ?? 0
        self.km = network?.km ?? 0
        self.minus = network?.minus ?? 0
        self.plus = network?.plus ?? 0
    }
}

public struct OrderUpdateExecutorCompensation {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double

    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
    init(from network: DNetOrderUpdateExecutorCompensation?) {
        self.minCost = network?.minCost ?? 0.0
        self.minKm = network?.minKm ?? 0.0
        self.cost = network?.cost ?? 0.0
    }
}

public struct OrderUpdateExecutorCoverBonus {
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
    init(from network: DNetOrderUpdateExecutorCoverBonus?) {
        self.approxPrice = network?.approxPrice ?? 0
        self.calculationType = network?.calculationType ?? ""
        self.cost = network?.cost ?? 0
        self.status = network?.status ?? false
    }
}

public struct OrderUpdateExecutorBonus {
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
    
    init(from network: DNetOrderUpdateExecutorBonus?) {
        self.cost = network?.cost ?? 0
        self.minCost = network?.minCost ?? 0
        self.minKm = network?.minKm ?? 0
        self.status = network?.status ?? false
    }
}

public struct OrderUpdateReason {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from network: DNetOrderUpdateReason?) {
        self.id = network?.id ?? 0
        self.name = network?.name ?? ""
    }
}

public struct OrderUpdateRoute {
    public let coords: OrderUpdateCoords
    public let lavel1: String
    public let level2: String

    public init(coords: OrderUpdateCoords, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }
    init(from network: DNetOrderUpdateRoute) {
        self.coords = OrderUpdateCoords(from: network.coords)
        self.lavel1 = network.lavel1
        self.level2 = network.level2
    }
}

public struct OrderUpdateCoords {
    public let lat: Double
    public let lng: Double

    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    init(from network: DNetOrderUpdateCoords) {
        self.lat = network.lat
        self.lng = network.lng
    }
}

public struct OrderUpdateStatusTime {
    public let status: String
    public let time: Int

    public init(status: String, time: Int) {
        self.status = status
        self.time = time
    }
    init(from network: DNetOrderUpdateStatusTime) {
        self.status = network.status ?? ""
        self.time = network.time ?? 0
    }
}
