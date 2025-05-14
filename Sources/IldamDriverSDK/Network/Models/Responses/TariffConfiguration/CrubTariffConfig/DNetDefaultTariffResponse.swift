//
//  DefaultTariffResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//


import Foundation

struct DNetDefaultTariffResult: DNetResBody {
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

struct DefaultTariffBrand: Codable {
    let id: Int
    let name: String
}
