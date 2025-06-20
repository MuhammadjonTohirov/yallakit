//
//  DriverTransactionResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public struct DriverTransactionModel {
    public let balance: Double
    public let transactions: [DriverTransactionItem]
    public let pagination: TransactionPaginationModel

    public init(balance: Double, transactions: [DriverTransactionItem], pagination: TransactionPaginationModel) {
        self.balance = balance
        self.transactions = transactions
        self.pagination = pagination
    }

    init(from network: DNetDriverTransactionResponse) {
        self.balance = network.balance ?? 0
        self.transactions = network.list.list.map(DriverTransactionItem.init)
        self.pagination = TransactionPaginationModel(from: network.list.pagination)
    }
}

public struct DriverTransactionItem {
    public let id: Int
    public let number: String
    public let address: String?
    public let operationType: String
    public let dateTime: String
    public let operationId: Int
    public let operationName: String
    public let amount: String
    public let note: String
    public let payTable: String
    public let payTableId: Int

    public init(
        id: Int,
        number: String,
        address: String?,
        operationType: String,
        dateTime: String,
        operationId: Int,
        operationName: String,
        amount: String,
        note: String,
        payTable: String,
        payTableId: Int
    ) {
        self.id = id
        self.number = number
        self.address = address
        self.operationType = operationType
        self.dateTime = dateTime
        self.operationId = operationId
        self.operationName = operationName
        self.amount = amount
        self.note = note
        self.payTable = payTable
        self.payTableId = payTableId
    }

    init(from network: DNetDriverTransactionItem) {
        self.id = network.id ?? 0
        self.number = network.number  ?? ""
        self.address = network.address  ?? ""
        self.operationType = network.operationType ?? ""
        self.dateTime = network.dateTime ?? ""
        self.operationId = network.operationId ?? 0
        self.operationName = network.operationName ?? ""
        self.amount = network.amount ?? ""
        self.note = network.note ?? ""
        self.payTable = network.payTable ?? ""
        self.payTableId = network.payTableId ?? 0
    }
}

public struct TransactionPaginationModel {
    public let total: Int
    public let count: Int
    public let perPage: Int
    public let currentPage: Int
    public let totalPages: Int
    public let lastPage: Int

    public init(
        total: Int,
        count: Int,
        perPage: Int,
        currentPage: Int,
        totalPages: Int,
        lastPage: Int
    ) {
        self.total = total
        self.count = count
        self.perPage = perPage
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.lastPage = lastPage
    }

    init(from network: DNetTransactionPagination) {
        self.total = network.total ?? 0
        self.count = network.count ?? 0
        self.perPage = network.perPage ?? 0
        self.currentPage = network.currentPage ?? 0
        self.totalPages = network.totalPages ?? 0
        self.lastPage = network.lastPage ?? 0
    }
}
