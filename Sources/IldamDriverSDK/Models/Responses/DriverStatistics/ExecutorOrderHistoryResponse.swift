//
//  ExecutorOrderHistoryResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public struct ExecutorOrderHistoryResponse {
    public let list: [ExecutorOrderHistoryItem]
    public let pagination: OrderHistoryPagination

    public init(list: [ExecutorOrderHistoryItem], pagination: OrderHistoryPagination) {
        self.list = list
        self.pagination = pagination
    }
    init(from network: DNetExecutorOrderHistoryResponse) {
        self.list = network.list.map(ExecutorOrderHistoryItem.init)
        self.pagination = OrderHistoryPagination(from: network.pagination)
    }
}

public struct ExecutorOrderHistoryItem {
    public let id: Int
    public let counterparty: Bool
    public let status: String
    public let sourceType: String
    public let slug: String
    public let createDate: String
    public let date: String
    public let totalPrice: Int
    public let distance: String
    public let tariffName: String
    public let name: String
    public let address: [OrderAddress]
    public let coverBonus: Int
    public let clientBonus: Int
    public let executorBonus: Int
    public let compensationBonus: Int

    public init(id: Int, counterparty: Bool, status: String, sourceType: String, slug: String, createDate: String, date: String, totalPrice: Int, distance: String, tariffName: String, name: String, address: [OrderAddress], coverBonus: Int, clientBonus: Int, executorBonus: Int, compensationBonus: Int) {
        self.id = id
        self.counterparty = counterparty
        self.status = status
        self.sourceType = sourceType
        self.slug = slug
        self.createDate = createDate
        self.date = date
        self.totalPrice = totalPrice
        self.distance = distance
        self.tariffName = tariffName
        self.name = name
        self.address = address
        self.coverBonus = coverBonus
        self.clientBonus = clientBonus
        self.executorBonus = executorBonus
        self.compensationBonus = compensationBonus
    }
    
    init(from network: DNetExecutorOrderHistoryItem) {
        self.id = network.id
        self.counterparty = network.counterparty
        self.status = network.status
        self.sourceType = network.sourceType
        self.slug = network.slug
        self.createDate = network.createDate
        self.date = network.date
        self.totalPrice = network.totalPrice
        self.distance = network.distance
        self.tariffName = network.tariffName
        self.name = network.name
        self.address = network.address.map(OrderAddress.init)
        self.coverBonus = network.coverBonus
        self.clientBonus = network.clientBonus
        self.executorBonus = network.executorBonus
        self.compensationBonus = network.compensationBonus
    }
}

public struct OrderAddress {
    public let name: String

    public init(name: String) {
        self.name = name
    }
    init(from network: DNetOrderAddress) {
        self.name = network.name
    }
}

public struct OrderHistoryPagination {
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
    
    init(from network: DNetPagination) {
        self.total = network.total
        self.count = network.count
        self.perPage = network.perPage
        self.currentPage = network.currentPage
        self.totalPages = network.totalPages
        self.lastPage = network.lastPage
    }
}
