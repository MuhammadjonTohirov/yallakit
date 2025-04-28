//
//  DriverOrderTariffConfigurationResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import NetworkLayer

public struct DriverOrderTariffConfigurationResponse: DNetResBody {
    public let cost: Int
    public let bonusAmount: Int
    public let id: Int
    public let useTheBonus: Bool
    public let executorCoverBonus: DNetResOrderTariffConfigurationResponse.NetResExecutorCoverBonus
    public let taxiTariff: DNetResOrderTariffConfigurationResponse.TaxiTariff
    public let inCity: DNetResOrderTariffConfigurationResponse.NetResCity?
    public let outCity: DNetResOrderTariffConfigurationResponse.NetResCity?
    public let service: [DNetResOrderService]?

    // MARK: - Internal conversion from network response
    init(from response: DNetResOrderTariffConfigurationResponse) {
        self.cost = response.cost
        self.bonusAmount = response.bonusAmount
        self.id = response.id
        self.useTheBonus = response.useTheBonus
        self.executorCoverBonus = response.executorCoverBonus
        self.taxiTariff = response.taxiTariff
        self.inCity = response.inCity
        self.outCity = response.outCity
        self.service = response.service
    }

    // MARK: - Public initializer
    public init(
        cost: Int,
        bonusAmount: Int,
        id: Int,
        useTheBonus: Bool,
        executorCoverBonus: DNetResOrderTariffConfigurationResponse.NetResExecutorCoverBonus,
        taxiTariff: DNetResOrderTariffConfigurationResponse.TaxiTariff,
        inCity: DNetResOrderTariffConfigurationResponse.NetResCity?,
        outCity: DNetResOrderTariffConfigurationResponse.NetResCity?,
        service: [DNetResOrderService]?
    ) {
        self.cost = cost
        self.bonusAmount = bonusAmount
        self.id = id
        self.useTheBonus = useTheBonus
        self.executorCoverBonus = executorCoverBonus
        self.taxiTariff = taxiTariff
        self.inCity = inCity
        self.outCity = outCity
        self.service = service
    }
}

