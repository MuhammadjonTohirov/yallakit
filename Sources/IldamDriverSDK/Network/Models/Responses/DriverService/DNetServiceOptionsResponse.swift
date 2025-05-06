//
//  ExecutorServiceOptionsResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

struct DNetServiceOptionsResponse: DNetResBody {
    let tariffOptions: [DNetTariffOption]
    let optionLists: [DNetOptionList]

    enum CodingKeys: String, CodingKey {
        case tariffOptions = "tariff_options"
        case optionLists = "option_lists"
    }
}

struct DNetTariffOption: Codable {
    let id: Int
    let name: String
    let allowedChoose: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case allowedChoose = "allowed_choose"
    }
}

struct DNetOptionList: Codable {
    let id: Int
    let cost: Int
    let icon: String?
    let allowedChoose: Bool
    let name: String
    let uz: String
    let ru: String

    enum CodingKeys: String, CodingKey {
        case id, cost, icon, name, uz, ru
        case allowedChoose = "allowed_choose"
    }
}
