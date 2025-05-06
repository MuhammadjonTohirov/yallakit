//
//  ExecutorServiceOptionsResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

public struct ExecutorServiceOptionsResponse {
    public let tariffOptions: [TariffOption]
    public let optionLists: [OptionList]

    public init(tariffOptions: [TariffOption], optionLists: [OptionList]) {
        self.tariffOptions = tariffOptions
        self.optionLists = optionLists
    }
    init(from network: DNetServiceOptionsResponse) {
        self.tariffOptions = network.tariffOptions.map { TariffOption(from: $0) }
        self.optionLists = network.optionLists.map { OptionList(from: $0) }
    }
}

public struct TariffOption {
    public let id: Int
    public let name: String
    public let allowedChoose: Bool

    public init(id: Int, name: String, allowedChoose: Bool) {
        self.id = id
        self.name = name
        self.allowedChoose = allowedChoose
    }
    init(from network: DNetTariffOption) {
        self.id = network.id
        self.name = network.name
        self.allowedChoose = network.allowedChoose
    }
}

public struct OptionList {
    public let id: Int
    public let cost: Int
    public let icon: String?
    public let allowedChoose: Bool
    public let name: String
    public let uz: String
    public let ru: String

    public init(id: Int, cost: Int, icon: String?, allowedChoose: Bool, name: String, uz: String, ru: String) {
        self.id = id
        self.cost = cost
        self.icon = icon
        self.allowedChoose = allowedChoose
        self.name = name
        self.uz = uz
        self.ru = ru
    }
    init(from network: DNetOptionList) {
        self.id = network.id
        self.cost = network.cost
        self.icon = network.icon
        self.allowedChoose = network.allowedChoose
        self.name = network.name
        self.uz = network.uz
        self.ru = network.ru
    }
}
