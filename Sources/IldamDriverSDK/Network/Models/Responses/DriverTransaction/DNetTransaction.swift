//
//  DNetTransaction.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

struct DNetDriverTransactionResponse: DNetResBody {
    let balance: Double?
    let list: DNetDriverTransactionList
}

struct DNetDriverTransactionList: Codable {
    let list: [DNetDriverTransactionItem]
    let pagination: DNetTransactionPagination
}

struct DNetDriverTransactionItem: Codable {
    let id: Int?
    let number: String?
    let address: String?
    let operationType: String?
    let dateTime: String?
    let operationId: Int?
    let operationName: String?
    let amount: String?
    let note: String?
    let payTable: String?
    let payTableId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, number, address
        case operationType = "operation_type"
        case dateTime = "date_time"
        case operationId = "operation_id"
        case operationName = "operation_name"
        case amount, note
        case payTable = "pay_table"
        case payTableId = "pay_table_id"
    }
}
struct DNetTransactionPagination: Codable {
    let total: Int?
    let count: Int?
    let perPage: Int?
    let currentPage: Int?
    let totalPages: Int?
    let lastPage: Int?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case lastPage = "last_page"
    }
}

