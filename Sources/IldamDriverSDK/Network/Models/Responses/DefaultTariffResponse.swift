//
//  DefaultTariffResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//


import Foundation
import SwiftUI
import NetworkLayer

public struct DefaultTariffResponse: NetResBody {
    let result: DefaultTariffResult
}

public struct DefaultTariffResult: Codable {
    let brand: DefaultTariffBrand
    let id: Int
    let minCityCost: Int
    let minOutCityCost: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case brand
        case id
        case minCityCost = "min_city_cost"
        case minOutCityCost = "min_out_city_cost"
        case name
    }
}

public struct DefaultTariffBrand: Codable {
    let id: Int
    let name: String
}
