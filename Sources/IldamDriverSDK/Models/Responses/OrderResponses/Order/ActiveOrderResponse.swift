//
//  ActiveOrderResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 27/05/25.
//

import Foundation

public struct ActiveOrderListResponse {
    public let orders: [ActiveOrder]
 
    public init(orders: [ActiveOrder]) {
        self.orders = orders
     }

    init(from network: DNetActiveOrderListResponse) {
        self.orders = network.list.map { ActiveOrder(from: $0) }
     }
}

public struct ActiveOrder {
    public let id: Int
    public let addressId: Int
    public let createdAt: Int
    public let coefficient: Int
    public let paymentType: String
    public let fixedPrice: Bool
    public let service: String
    public let sourceType: String
    public let status: String
    public let useTheBonus: Bool

    public let brandName: String
    public let brandAddress: String
    public let brandService: String

    public let tariffName: String
    public let cost: Int
    public let bonusAmount: Int
    public let modifPrice: Int
    public let modifPriceEvent: String
    public let serviceNames: [String]

    public let directionDistance: Double
    public let directionDuration: Double
    public let directionMapType: String

    public let executorBonus: ExecutorActiveOrderBonus
    public let executorCompensation: ExecutorActiveOrderCompensation?
    public let executorCoverBonus: ExecutorActiveOrderCoverBonus

    public let routeDescription: String

    public init(
        id: Int,
        addressId: Int,
        createdAt: Int,
        coefficient: Int,
        paymentType: String,
        fixedPrice: Bool,
        service: String,
        sourceType: String,
        status: String,
        useTheBonus: Bool,
        brandName: String,
        brandAddress: String,
        brandService: String,
        tariffName: String,
        cost: Int,
        bonusAmount: Int,
        modifPrice: Int,
        modifPriceEvent: String,
        serviceNames: [String],
        directionDistance: Double,
        directionDuration: Double,
        directionMapType: String,
        executorBonus: ExecutorActiveOrderBonus,
        executorCompensation: ExecutorActiveOrderCompensation?,
        executorCoverBonus: ExecutorActiveOrderCoverBonus,
        routeDescription: String
    ) {
        self.id = id
        self.addressId = addressId
        self.createdAt = createdAt
        self.coefficient = coefficient
        self.paymentType = paymentType
        self.fixedPrice = fixedPrice
        self.service = service
        self.sourceType = sourceType
        self.status = status
        self.useTheBonus = useTheBonus
        self.brandName = brandName
        self.brandAddress = brandAddress
        self.brandService = brandService
        self.tariffName = tariffName
        self.cost = cost
        self.bonusAmount = bonusAmount
        self.modifPrice = modifPrice
        self.modifPriceEvent = modifPriceEvent
        self.serviceNames = serviceNames
        self.directionDistance = directionDistance
        self.directionDuration = directionDuration
        self.directionMapType = directionMapType
        self.executorBonus = executorBonus
        self.executorCompensation = executorCompensation
        self.executorCoverBonus = executorCoverBonus
        self.routeDescription = routeDescription
    }

    init(from network: DNetActiveOrder) {
        self.id = network.id
        self.addressId = network.addressId
        self.createdAt = network.createdAt
        self.coefficient = network.coefficient
        self.paymentType = network.paymentType
        self.fixedPrice = network.fixedPrice
        self.service = network.service
        self.sourceType = network.sourceType
        self.status = network.status
        self.useTheBonus = network.useTheBonus

        self.brandName = network.brand.name
        self.brandAddress = network.brand.addressName
        self.brandService = network.brand.serviceName

        self.tariffName = network.detail.tariffName
        self.cost = network.detail.cost
        self.bonusAmount = network.detail.bonusAmount
        self.modifPrice = network.detail.modifPrice
        self.modifPriceEvent = network.detail.modifPriceEvent
        self.serviceNames = network.detail.services.map { $0.name }

        self.directionDistance = network.directionToClient.distance
        self.directionDuration = network.directionToClient.duration
        self.directionMapType = network.directionToClient.mapType

        self.executorBonus = ExecutorActiveOrderBonus(
            cost: network.executorBonus.cost,
            minCost: network.executorBonus.minCost,
            minKm: network.executorBonus.minKm,
            status: network.executorBonus.status
        )

        self.executorCompensation = network.executorCompensation.map {
            ExecutorActiveOrderCompensation(minCost: $0.minCost, minKm: $0.minKm, cost: $0.cost)
        }

        self.executorCoverBonus = ExecutorActiveOrderCoverBonus(
            approxPrice: network.executorCoverBonus.approxPrice,
            calculationType: network.executorCoverBonus.calculationType,
            cost: network.executorCoverBonus.cost,
            status: network.executorCoverBonus.status
        )

        self.routeDescription = network.routes
            .map { "\($0.lavel1) → \($0.level2)" }
            .joined(separator: ", ")
    }
}

public struct ActiveOrderPagination {
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

    init(from network: DNetResPagination) {
        self.count = network.count ?? 0
        self.currentPage = network.currentPage ?? 1
        self.lastPage = network.lastPage ?? 1
        self.perPage = network.perPage ?? 0
        self.total = network.total ?? 0
        self.totalPages = network.totalPages ?? 1
    }
}

public struct ExecutorActiveOrderBonus {
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

public struct ExecutorActiveOrderCompensation {
    public let minCost: Double
    public let minKm: Double
    public let cost: Double

    public init(minCost: Double, minKm: Double, cost: Double) {
        self.minCost = minCost
        self.minKm = minKm
        self.cost = cost
    }
}

public struct ExecutorActiveOrderCoverBonus {
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
}
