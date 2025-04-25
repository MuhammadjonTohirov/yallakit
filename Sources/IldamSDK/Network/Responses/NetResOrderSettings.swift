//
//  NetResOrderSettings.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 19/12/24.
//

import Foundation

struct NetResOrderSettings: NetResBody {
    let orderCancelTime: Int
    let maxBonus: Float?
    let minBonus: Float?
    let useBonus: Bool?
    
    enum CodingKeys: String, CodingKey {
        case orderCancelTime = "order_cancel_time"
        case maxBonus = "max_bonus"
        case minBonus = "min_bonus"
        case useBonus = "use_the_bonus"
    }
}
