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
    
    init(from network: DNetDriverConfigurationResponse) {
        self.autoWaitingCalc = network.autoWaitingCalc
        self.blackList = network.blackList
        self.countEfirOnExecutor = network.countEfirOnExecutor
        self.energyManagement = network.energyManagement
        self.expireTime = network.expireTime
        self.fotocontrol = network.fotocontrol
        self.nonstopReOfferIn = network.nonstopReOfferIn
        self.paymentSetting = PaymentSetting(from: network.paymentSetting)
        self.result = EnergyConfiguration(from: network.result)
        self.roundingCost = network.roundingCost
        self.roundingType = network.roundingType
        self.speed = network.speed
        self.supportNumber = network.supportNumber
        self.twoGisKey = network.twoGisKey
        self.waitingTime = network.waitingTime
    }
}
public struct PaymentSetting: Codable {
    public let holdBalance: Int
    public let isWorking: Bool
    public let maxFill: Int
    public let maxWithdrawMoney: Int
    public let minFill: Int
    public let minWithdrawMoney: Int

    public init(
        holdBalance: Int,
        isWorking: Bool,
        maxFill: Int,
        maxWithdrawMoney: Int,
        minFill: Int,
        minWithdrawMoney: Int
    ) {
        self.holdBalance = holdBalance
        self.isWorking = isWorking
        self.maxFill = maxFill
        self.maxWithdrawMoney = maxWithdrawMoney
        self.minFill = minFill
        self.minWithdrawMoney = minWithdrawMoney
    }
    
    init(from network: DNetResPaymentSetting) {
        self.holdBalance = network.holdBalance
        self.isWorking = network.isWorking
        self.maxFill = network.maxFill
        self.maxWithdrawMoney = network.maxWithdrawMoney
        self.minFill = network.minFill
        self.minWithdrawMoney = network.minWithdrawMoney
    }
}


public struct EnergyConfiguration: Codable {
    public let long: EnergyType
    public let middle: EnergyType
    public let noStandart: EnergyType
    public let short: EnergyType

    public init(
        long: EnergyType,
        middle: EnergyType,
        noStandart: EnergyType,
        short: EnergyType
    ) {
        self.long = long
        self.middle = middle
        self.noStandart = noStandart
        self.short = short
    }
    
    init(from network: DNetResEnergyGroup) {
        self.long = EnergyType(from: network.long)
        self.middle = EnergyType(from: network.middle)
        self.noStandart = EnergyType(from: network.noStandart)
        self.short = EnergyType(from: network.short)
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
    
    init(from network: DNetResEnergy) {
        self.cancel = network.cancel
        self.km = network.km
        self.minus = network.minus
        self.plus = network.plus
    }
}

