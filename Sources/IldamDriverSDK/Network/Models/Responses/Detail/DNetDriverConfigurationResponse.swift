//
//  DNetResDriverConfiguration.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import Foundation

struct DNetDriverConfigurationResponse: DNetResBody {
    let autoWaitingCalc: Bool
    let blackList: String
    let countEfirOnExecutor: Int
    let energyManagement: Bool
    let expireTime: Int
    let fotocontrol: Bool
    let nonstopReOfferIn: Int
    let paymentSetting: DNetResPaymentSetting
    let reason: DNetConfigResponse
    let result: DNetResEnergyGroup
    let roundingCost: Int
    let roundingType: String
    let speed: Int
    let supportNumber: String
    let twoGisKey: String?
    let waitingTime: Int

    enum CodingKeys: String, CodingKey {
        case autoWaitingCalc = "auto_waiting_calc"
        case blackList = "black_list"
        case countEfirOnExecutor = "count_efir_on_executor"
        case energyManagement = "energy_management"
        case expireTime = "expire_time"
        case fotocontrol
        case nonstopReOfferIn = "nonstop_re_offer_in"
        case reason
        case paymentSetting = "payment_setting"
        case result
        case roundingCost = "rounding_cost"
        case roundingType = "rounding_type"
        case speed
        case supportNumber = "support_number"
        case twoGisKey = "two_gis_key"
        case waitingTime = "waiting_time"
    }
}

struct DNetResPaymentSetting: Codable {
    let holdBalance: Int
    let isWorking: Bool
    let maxFill: Int
    let maxWithdrawMoney: Int
    let minFill: Int
    let minWithdrawMoney: Int

    enum CodingKeys: String, CodingKey {
        case holdBalance = "hold_balance"
        case isWorking = "is_working"
        case maxFill = "max_fill"
        case maxWithdrawMoney = "max_withdraw_money"
        case minFill = "min_fill"
        case minWithdrawMoney = "min_withdraw_money"
    }
}

struct DNetResEnergyGroup: Codable {
    let long, middle, noStandart, short: DNetResEnergy

    enum CodingKeys: String, CodingKey {
        case long, middle
        case noStandart = "no_standart"
        case short
    }
}

struct DNetResEnergy: Codable {
    let cancel: Int
    let km: Int
    let minus: Int
    let plus: Int
}

struct DNetConfigResponse: Codable {
    let id: Int
    let name: String
}

