//
//  DriverOrderAppointedResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI
import Core
import NetworkLayer

public struct DriverOrderAppointedResponse: DNetResBody {
    public let addressId: Int
    public let brand: AppointedOrderBrand
    public let clientPhone: String
    public let coefficient: Double
    public let createdAt: Int
    public let detail: AppointedOrderDetail
    public let directionToClient: AppointedOrderDirectionToClient
    public let dontCallMe: Bool
    public let energy: AppointedOrderEnergy
    public let executorBonus: AppointedOrderExecutorBonus
    public let executorCompensation: AppointedOrderExecutorCompensation?
    public let executorCoverBonus: AppointedOrderExecutorCoverBonus
    public let fixedPrice: Bool
    public let id: Int
    public let paymentType: String
    public let reason: AppointedOrderReason?
    public let roadDirection: AppointedOrderRoadDirection
    public let routes: [AppointedOrderRoute]
    public let sendingTime: Int
    public let service: String
    public let sourceType: String
    public let status: String
    public let statusTime: [AppointedOrderStatusTime]
    public let toPhone: String
    public let useTheBonus: Bool
    
    public init(addressId: Int, brand: AppointedOrderBrand, clientPhone: String, coefficient: Double, createdAt: Int, detail: AppointedOrderDetail, directionToClient: AppointedOrderDirectionToClient, dontCallMe: Bool, energy: AppointedOrderEnergy, executorBonus: AppointedOrderExecutorBonus, executorCompensation: AppointedOrderExecutorCompensation?, executorCoverBonus: AppointedOrderExecutorCoverBonus, fixedPrice: Bool, id: Int, paymentType: String, reason: AppointedOrderReason?, roadDirection: AppointedOrderRoadDirection, routes: [AppointedOrderRoute], sendingTime: Int, service: String, sourceType: String, status: String, statusTime: [AppointedOrderStatusTime], toPhone: String, useTheBonus: Bool) {
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
    
    init(network: DNetResAppointedOrder) {
        self.addressId = network.addressId
        self.brand = AppointedOrderBrand(
            addressName: network.brand.addressName,
            name: network.brand.name,
            serviceName: network.brand.serviceName
        )
        self.clientPhone = network.clientPhone
        self.coefficient = network.coefficient
        self.createdAt = network.createdAt
        self.detail = AppointedOrderDetail(
            approxDistance: network.detail.approxDistance,
            approxDuration: network.detail.approxDuration,
            approxTotalPrice: network.detail.approxTotalPrice,
            bonusAmount: network.detail.bonusAmount,
            comment: network.detail.comment,
            cost: network.detail.cost,
            distance: network.detail.distance,
            duration: network.detail.duration,
            modifPrice: network.detail.modifPrice,
            modifPriceEvent: network.detail.modifPriceEvent,
            services: network.detail.services?.map { service in
                AppointedOrderService(
                    cost: service.cost,
                    costType: service.costType,
                    name: service.name
                )
            },
            tariffName: network.detail.tariffName
        )
        self.directionToClient = AppointedOrderDirectionToClient(
            distance: network.directionToClient.distance,
            duration: network.directionToClient.duration,
            mapType: network.directionToClient.mapType
        )
        self.dontCallMe = network.dontCallMe
        self.energy = AppointedOrderEnergy(
            cancel: network.energy.cancel,
            km: network.energy.km,
            minus: network.energy.minus,
            plus: network.energy.plus
        )
        self.executorBonus = AppointedOrderExecutorBonus(
            cost: network.executorBonus.cost,
            minCost: network.executorBonus.minCost,
            minKm: network.executorBonus.minKm,
            status: network.executorBonus.status
        )
        self.executorCompensation = network.executorCompensation.map { compensation in
            AppointedOrderExecutorCompensation(
                approxPrice: compensation.approxPrice,
                calculationType: compensation.calculationType,
                cost: compensation.cost,
                distance: compensation.distance,
                duration: compensation.duration,
                status: compensation.status
            )
        }
        self.executorCoverBonus = AppointedOrderExecutorCoverBonus(
            approxPrice: network.executorCoverBonus.approxPrice,
            calculationType: network.executorCoverBonus.calculationType,
            cost: network.executorCoverBonus.cost,
            distance: network.executorCoverBonus.distance,
            duration: network.executorCoverBonus.duration,
            status: network.executorCoverBonus.status
        )
        self.fixedPrice = network.fixedPrice
        self.id = network.id
        self.paymentType = network.paymentType
        self.reason = AppointedOrderReason(id: network.reason?.id ?? 0, name: network.reason?.name ?? "")
        self.roadDirection = AppointedOrderRoadDirection(
            distance: network.roadDirection.distance,
            duration: network.roadDirection.duration
        )
        self.routes = network.routes.map { route in
            AppointedOrderRoute(
                coords: AppointedOrderCoords(
                    lat: route.coords.lat,
                    lng: route.coords.lng
                ),
                lavel1: route.lavel1,
                level2: route.level2
            )
        }
        self.sendingTime = network.sendingTime
        self.service = network.service
        self.sourceType = network.sourceType
        self.status = network.status
        self.statusTime = network.statusTime.map { time in
            AppointedOrderStatusTime(
                status: time.status,
                time: time.time
            )
        }
        self.toPhone = network.toPhone
        self.useTheBonus = network.useTheBonus
    }
}
public struct AppointedOrderBrand: Codable {
    public let addressName: String
    public let name: String
    public let serviceName: String
    
   public init(addressName: String, name: String, serviceName: String) {
        self.addressName = addressName
        self.name = name
        self.serviceName = serviceName
    }
}

public struct AppointedOrderDetail: Codable {
    public let approxDistance: Double
    public let approxDuration: Double
    public let approxTotalPrice: Double
    public let bonusAmount: Int
    public let comment: String
    public let cost: Double
    public let distance: Double
    public let duration: String
    public let modifPrice: Double
    public let modifPriceEvent: String
    public let services: [AppointedOrderService]?
    public let tariffName: String
 
    public init(approxDistance: Double, approxDuration: Double, approxTotalPrice: Double, bonusAmount: Int, comment: String, cost: Double, distance: Double, duration: String, modifPrice: Double, modifPriceEvent: String, services: [AppointedOrderService]?, tariffName: String) {
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
}

public struct AppointedOrderService: Codable {
    public let cost: Int
    public let costType: String
    public let name: String

    public init(cost: Int, costType: String, name: String) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
}

public struct AppointedOrderDirectionToClient: Codable {
    public let distance: Double
    public let duration: Double
    public let mapType: String
    
    public init(distance: Double, duration: Double, mapType: String) {
        self.distance = distance
        self.duration = duration
        self.mapType = mapType
    }
}

public struct AppointedOrderEnergy: Codable {
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
}

public struct AppointedOrderExecutorBonus: Codable {
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
}

public struct AppointedOrderExecutorCompensation: Codable {
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
}

public struct AppointedOrderExecutorCoverBonus: Codable {
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
}

public struct AppointedOrderRoadDirection: Codable {
    public let distance: Int
    public let duration: Int
    
    public init(distance: Int, duration: Int) {
        self.distance = distance
        self.duration = duration
    }
}

public struct AppointedOrderRoute: Codable {
    public let coords: AppointedOrderCoords
    public let lavel1: String
    public let level2: String
    
    public init(coords: AppointedOrderCoords, lavel1: String, level2: String) {
        self.coords = coords
        self.lavel1 = lavel1
        self.level2 = level2
    }

}

public struct AppointedOrderCoords: Codable {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

public struct AppointedOrderStatusTime: Codable {
    public let status: String
    public let time: Int
    
    public init(status: String, time: Int) {
        self.status = status
        self.time = time
    }
}
public struct AppointedOrderReason: Codable {
    let id: Int
    let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
