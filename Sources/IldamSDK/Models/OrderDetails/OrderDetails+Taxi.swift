//
//  OrderDetails+Taxi.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public struct OrderTaxiDetails: Codable, Sendable {
    @available(*, deprecated, message: "This field will be deleted soon", renamed: "orderDetails.tariff.name")
    public var tariff: String
    public var startPrice: Float?
    public var distance: Float?
    public var clientTotalPrice: Float
    public var totalPrice: Float?
    public var fixedPrice: Bool
    public var isUsingBonus: Bool?
    public var bonusAmount: Double?
    // write deprecated messages
    @available(*, deprecated, message: "This field will be deleted soon", renamed: "orderDetails.routes")
    public var routes: [OrderRoute]
    public var services: [OrderServiceItem]?
    public var award: Award?
    public var waitingTime: Float?
    public var waitingCost: Float?

    public init(
        tariff: String,
        startPrice: Float?,
        distance: Float?,
        clientTotalPrice: Float,
        totalPrice: Float?,
        fixedPrice: Bool,
        isUsingBonus: Bool? = nil,
        bonusAmount: Double? = nil,
        routes: [OrderRoute],
        services: [OrderServiceItem]? = nil,
        award: Award? = nil,
        waitingTime: Float? = nil,
        waitingCost: Float? = nil
    ) {
        self.tariff = tariff
        self.startPrice = startPrice
        self.distance = distance
        self.clientTotalPrice = clientTotalPrice
        self.totalPrice = totalPrice
        self.fixedPrice = fixedPrice
        self.isUsingBonus = isUsingBonus
        self.bonusAmount = bonusAmount
        self.routes = routes
        self.services = services
        self.award = award
        self.waitingTime = waitingTime
        self.waitingCost = waitingCost
    }
    
    init?(res: NetResOrderDetails?) {
        guard let res = res else { return nil }
        self.tariff = res.tariff?.name ?? res.taxi?.tariff ?? ""
        self.startPrice = res.taxi?.startPrice
        self.distance = res.taxi?.distance
        self.clientTotalPrice = res.taxi?.clientTotalPrice ?? 0
        self.fixedPrice = res.taxi?.fixedPrice ?? false
        self.totalPrice = res.taxi?.totalPrice
        self.routes = res.routes?.compactMap(OrderRoute.init) ?? (res.taxi?.routes ?? []).compactMap(OrderRoute.init)
        self.services = res.taxi?.services?.compactMap(OrderServiceItem.init)
        self.bonusAmount = res.taxi?.bonusAmount
        self.isUsingBonus = res.taxi?.bonusAmount != nil
        self.award = res.taxi?.award.map { Award(amount: $0.amount, type: $0.type) }
        self.waitingCost = res.taxi?.waitingCost
        if let waitingTime = res.taxi?.waitingTime, waitingTime > 0 {
            self.waitingTime = waitingTime
        } else {
            self.waitingTime = nil
        }
    }
    
    init?(taxiRes res: NetResOrderTaxiDetails?) {
        guard let res else {
            return nil
        }
        
        self.tariff = res.tariff ?? ""
        self.startPrice = res.startPrice
        self.distance = res.distance
        self.clientTotalPrice = res.clientTotalPrice ?? 0
        self.fixedPrice = res.fixedPrice ?? false
        self.totalPrice = res.totalPrice
        self.routes = res.routes?.compactMap(OrderRoute.init) ?? []
        self.bonusAmount = res.bonusAmount
        self.isUsingBonus = res.bonusUsed
        self.award = res.award.map { Award(amount: $0.amount, type: $0.type) }
        self.waitingTime = res.waitingTime
        self.waitingCost = res.waitingCost
    }
    
    public struct Award: Codable, Sendable {
        public var amount: Int
        public var type: String
        
        public init(amount: Int, type: String) {
            self.amount = amount
            self.type = type
        }
    }
}
