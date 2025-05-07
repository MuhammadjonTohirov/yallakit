//
//  ExecutorOrderShowHistoryResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public struct ExecutorOrderShowHistoryResponse {
    public let id: Int
    public let addressId: Int
    public let service: String
    public let status: String
    public let paymentType: String
    public let fixedPrice: Bool
    public let reason: OrderHistoryReasonModel?
    public let routes: [OrderRouteModel]
    public let totalPrice: Double
    public let commission: Double
    public let energy: Double
    public let counterparty: Bool
    public let clientPhone: String
    public let track: [OrderHistoryTripTrackModel]?
    public let brandName: String
    public let createdAt: Int
    public let complateTime: Int
    public let comment: String?
    public let tariff: String
    public let distance: String
    public let services: [OrderServiceModel]
    public let modifPrice: OrderModifPriceModel
    public let executorBonus: Double
    public let compensationBonus: Double
    public let coverBonus: Double
    public let clientBonus: Double

    public init(
        id: Int,
        addressId: Int,
        service: String,
        status: String,
        paymentType: String,
        fixedPrice: Bool,
        reason: OrderHistoryReasonModel?,
        routes: [OrderRouteModel],
        totalPrice: Double,
        commission: Double,
        energy: Double,
        counterparty: Bool,
        clientPhone: String,
        track: [OrderHistoryTripTrackModel]?,
        brandName: String,
        createdAt: Int,
        complateTime: Int,
        comment: String?,
        tariff: String,
        distance: String,
        services: [OrderServiceModel],
        modifPrice: OrderModifPriceModel,
        executorBonus: Double,
        compensationBonus: Double,
        coverBonus: Double,
        clientBonus: Double
    ) {
        self.id = id
        self.addressId = addressId
        self.service = service
        self.status = status
        self.paymentType = paymentType
        self.fixedPrice = fixedPrice
        self.reason = reason
        self.routes = routes
        self.totalPrice = totalPrice
        self.commission = commission
        self.energy = energy
        self.counterparty = counterparty
        self.clientPhone = clientPhone
        self.track = track
        self.brandName = brandName
        self.createdAt = createdAt
        self.complateTime = complateTime
        self.comment = comment
        self.tariff = tariff
        self.distance = distance
        self.services = services
        self.modifPrice = modifPrice
        self.executorBonus = executorBonus
        self.compensationBonus = compensationBonus
        self.coverBonus = coverBonus
        self.clientBonus = clientBonus
    }

    init(from network: DNetOrderHistoryShowResponse) {
        self.id = network.id
        self.addressId = network.addressId
        self.service = network.service
        self.status = network.status
        self.paymentType = network.paymentType
        self.fixedPrice = network.fixedPrice
        self.reason = network.reason.map(OrderHistoryReasonModel.init)
        self.routes = network.routes.map(OrderRouteModel.init)
        self.totalPrice = network.totalPrice
        self.commission = network.comission
        self.energy = network.energy
        self.counterparty = network.counterparty
        self.clientPhone = network.clientPhone
        self.track = network.track?.map(OrderHistoryTripTrackModel.init)
        self.brandName = network.brandName
        self.createdAt = network.createdAt
        self.complateTime = network.complateTime
        self.comment = network.comment
        self.tariff = network.tariff
        self.distance = network.distance
        self.services = network.services.map(OrderServiceModel.init)
        self.modifPrice = OrderModifPriceModel(from: network.modifPrice)
        self.executorBonus = network.executorBonus
        self.compensationBonus = network.compensationBonus
        self.coverBonus = network.coverBonus
        self.clientBonus = network.clientBonus
    }
}
public struct OrderRouteModel {
    public let index: Int
    public let name: String
    public let lat: String
    public let lng: String

    public init(index: Int, name: String, lat: String, lng: String) {
        self.index = index
        self.name = name
        self.lat = lat
        self.lng = lng
    }

    init(from network: DNetOrderRoute) {
        self.index = network.index
        self.name = network.name
        self.lat = network.lat
        self.lng = network.lng
    }
}
public struct OrderServiceModel {
    public let id: Int
    public let name: String
    public let uz: String
    public let ru: String

    public init(id: Int, name: String, uz: String, ru: String) {
        self.id = id
        self.name = name
        self.uz = uz
        self.ru = ru
    }

    init(from network: DNetOrderService) {
        self.id = network.id
        self.name = network.name
        self.uz = network.uz
        self.ru = network.ru
    }
}
public struct OrderModifPriceModel {
    public let modifPrice: String
    public let modifPriceEvent: String?

    public init(modifPrice: String, modifPriceEvent: String?) {
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
    }

    init(from network: DNetOrderModifPrice) {
        self.modifPrice = network.modifPrice
        self.modifPriceEvent = network.modifPriceEvent
    }
}
public struct OrderHistoryReasonModel {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    init(from network: DNetOrderHistoryReason) {
        self.id = network.id
        self.name = network.name
    }
}
public struct OrderHistoryTripTrackModel {
    public let heading: Double
    public let lat: Double
    public let lng: Double
    public let speed: Double
    public let status: String?

    public init(heading: Double, lat: Double, lng: Double, speed: Double, status: String?) {
        self.heading = heading
        self.lat = lat
        self.lng = lng
        self.speed = speed
        self.status = status
    }

    init(from network: DNetOrderHistoryTripTrack) {
        self.heading = network.heading
        self.lat = network.lat
        self.lng = network.lng
        self.speed = network.speed
        self.status = network.status
    }
}
