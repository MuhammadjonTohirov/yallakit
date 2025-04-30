//
//  DNetOrderCancelResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//


import Foundation
import NetworkLayer

struct DNetOrderCancelResponse: DNetResBody {
    let result: DNetOrderCancelResult
}

struct DNetOrderCancelResult: Codable {
    let id: Int
    let status: String
}
