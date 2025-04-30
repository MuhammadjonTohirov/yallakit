//
//  DriverConfiguration.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//


import Foundation

public struct DriverConfiguration: Codable {
    public let autoWaitingCalc: Bool
    public let blackList: String
    public let countEfirOnExecutor: Int
    public let energyManagement: Bool
    public let expireTime: Int
    public let fotocontrol: Bool
    public let nonstopReOfferIn: Int
    public let paymentSetting: PaymentSetting
    public let result: EnergyConfiguration
    public let roundingCost: Int
    public let roundingType: String
    public let speed: Int
    public let supportNumber: String
    public let twoGisKey: String?
    public let waitingTime: Int

    public init(
        autoWaitingCalc: Bool,
        blackList: String,
        countEfirOnExecutor: Int,
        energyManagement: Bool,
        expireTime: Int,
        fotocontrol: Bool,
        nonstopReOfferIn: Int,
        paymentSetting: PaymentSetting,
        result: EnergyConfiguration,
        roundingCost: Int,
        roundingType: String,
        speed: Int,
        supportNumber: String,
        twoGisKey: String?,
        waitingTime: Int
    ) {
        self.autoWaitingCalc = autoWaitingCalc
        self.blackList = blackList
        self.countEfirOnExecutor = countEfirOnExecutor
        self.energyManagement = energyManagement
        self.expireTime = expireTime
        self.fotocontrol = fotocontrol
        self.nonstopReOfferIn = nonstopReOfferIn
        self.paymentSetting = paymentSetting
        self.result = result
        self.roundingCost = roundingCost
        self.roundingType = roundingType
        self.speed = speed
        self.supportNumber = supportNumber
        self.twoGisKey = twoGisKey
        self.waitingTime = waitingTime
    }

    enum CodingKeys: String, CodingKey {
        case autoWaitingCalc = "auto_waiting_calc"
        case blackList = "black_list"
        case countEfirOnExecutor = "count_efir_on_executor"
        case energyManagement = "energy_management"
        case expireTime = "expire_time"
        case fotocontrol
        case nonstopReOfferIn = "nonstop_re_offer_in"
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

public struct PaymentSetting: Codable {
    public let holdBalance: Int
    public let isWorking: Bool
    public let maxFill: Int
    public let maxWithdrawMoney: Int
    public let minFill: Int
    public let minWithdrawMoney: Int

    public init(holdBalance: Int, isWorking: Bool, maxFill: Int, maxWithdrawMoney: Int, minFill: Int, minWithdrawMoney: Int) {
        self.holdBalance = holdBalance
        self.isWorking = isWorking
        self.maxFill = maxFill
        self.maxWithdrawMoney = maxWithdrawMoney
        self.minFill = minFill
        self.minWithdrawMoney = minWithdrawMoney
    }

    enum CodingKeys: String, CodingKey {
        case holdBalance = "hold_balance"
        case isWorking = "is_working"
        case maxFill = "max_fill"
        case maxWithdrawMoney = "max_withdraw_money"
        case minFill = "min_fill"
        case minWithdrawMoney = "min_withdraw_money"
    }
}

public struct EnergyConfiguration: Codable {
    public let long: EnergyType
    public let middle: EnergyType
    public let noStandart: EnergyType
    public let short: EnergyType

    public init(long: EnergyType, middle: EnergyType, noStandart: EnergyType, short: EnergyType) {
        self.long = long
        self.middle = middle
        self.noStandart = noStandart
        self.short = short
    }

    enum CodingKeys: String, CodingKey {
        case long
        case middle
        case noStandart = "no_standart"
        case short
    }
}

public struct EnergyType: Codable {
    public let cancel: Int
    public let km: Int
    public let minus: Int
    public let plus: Int

    public init(cancel: Int, km: Int, minus: Int, plus: Int) {
        self.cancel = cancel
        self.km = km
        self.minus = minus
        self.plus = plus
    }
}
