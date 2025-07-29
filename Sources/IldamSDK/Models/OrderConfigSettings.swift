//
//  OrderConfigSettings.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 05/03/25.
//

import Foundation

public struct OrderConfigSettings: Codable, Sendable {
    public let efirTime: Int?
    public let expireTime: Int?
    public let findRadius: Float?
    public let maxBonus: Float?
    public let minBonus: Float?
    public let orderCancelTime: Int?
    public let reasons: [CancelReason]
    public let sendEfirRadius: Int?
    public let supportNumber: String?
    public let timeToEfir: Int?
    public let useBonus: Bool?
    
    public init(efirTime: Int?, expireTime: Int?, findRadius: Float?, maxBonus: Float?, minBonus: Float?, orderCancelTime: Int?, reasons: [CancelReason], sendEfirRadius: Int?, supportNumber: String?, timeToEfir: Int?, useBonus: Bool?) {
        self.efirTime = efirTime
        self.expireTime = expireTime
        self.findRadius = findRadius
        self.maxBonus = maxBonus
        self.minBonus = minBonus
        self.orderCancelTime = orderCancelTime
        self.reasons = reasons
        self.sendEfirRadius = sendEfirRadius
        self.supportNumber = supportNumber
        self.timeToEfir = timeToEfir
        self.useBonus = useBonus
    }
}

extension OrderConfigSettings {
    init?(res: NetResOrderSettings?) {
        guard let res = res else { return nil }
        self.orderCancelTime = res.orderCancelTime
        self.maxBonus = res.maxBonus
        self.minBonus = res.minBonus
        self.useBonus = res.useBonus
        self.efirTime = res.efirTime
        self.expireTime = res.expireTime
        self.findRadius = res.findRadius
        self.reasons = res.reasons.compactMap({.init(id: $0.id, name: $0.name)})
        self.sendEfirRadius = res.sendEfirRadius
        self.supportNumber = res.supportNumber
        self.timeToEfir = res.timeToEfir
        
    }
}

public extension OrderConfigSettings {
    struct CancelReason: Codable, Sendable {
        public let id: Int
        public let name: String
        
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }
}
