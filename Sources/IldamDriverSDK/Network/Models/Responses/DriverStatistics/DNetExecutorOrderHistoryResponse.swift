//
//  DNetExecutorOrderHistoryResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

struct DNetExecutorOrderHistoryResponse: DNetResBody {
    let list: [DNetExecutorOrderHistoryItem]
    let pagination: DNetPagination
}

struct DNetExecutorOrderHistoryItem: Codable {
    let id: Int
    let counterparty: Bool
    let status: String
    let sourceType: String
    let slug: String
    let createDate: String
    let date: String
    let totalPrice: Int
    let distance: String
    let tariffName: String
    let name: String
    let address: [DNetOrderAddress]
    let coverBonus: Int
    let clientBonus: Int
    let executorBonus: Int
    let compensationBonus: Int

    enum CodingKeys: String, CodingKey {
        case id, counterparty, status
        case sourceType = "source_type"
        case slug
        case createDate = "create_date"
        case date
        case totalPrice = "total_price"
        case distance
        case tariffName = "tariff_name"
        case name
        case address
        case coverBonus = "cover_bonus"
        case clientBonus = "client_bonus"
        case executorBonus = "executor_bonus"
        case compensationBonus = "compensation_bonus"
    }
}

struct DNetOrderAddress: Codable {
    let name: String
}

struct DNetPagination: Codable {
    let total: Int
    let count: Int
    let perPage: String
    let currentPage: Int
    let totalPages: Int
    let lastPage: Int

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case lastPage = "last_page"
    }
}
