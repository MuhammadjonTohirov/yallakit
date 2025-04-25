//
//  OrderConfigSettings.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 05/03/25.
//

import Foundation

public struct OrderConfigSettings: Codable {
    public let orderCancelTime: Int
    public let maxBonus: Float?
    public let minBonus: Float?
    public let useBonus: Bool?
    
    public init(orderCancelTime: Int, maxBonus: Float?, minBonus: Float?, useBonus: Bool?) {
        self.orderCancelTime = orderCancelTime
        self.maxBonus = maxBonus
        self.minBonus = minBonus
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
    }
}
