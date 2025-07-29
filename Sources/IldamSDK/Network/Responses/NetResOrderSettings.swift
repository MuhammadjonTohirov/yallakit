//
//  NetResOrderSettings.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 19/12/24.
//

import Foundation

struct NetResOrderSettings: NetResBody, Sendable {
    let efirTime: Int?
    let expireTime: Int?
    let findRadius: Float?
    let maxBonus: Float?
    let minBonus: Float?
    let orderCancelTime: Int?
    let reasons: [CancelReason]
    let sendEfirRadius: Int?
    let supportNumber: String?
    let timeToEfir: Int?
    let useBonus: Bool?
    
    enum CodingKeys: String, CodingKey {
        case efirTime = "efir_time"
        case expireTime = "expire_time"
        case findRadius = "find_radius"
        case maxBonus = "max_bonus"
        case minBonus = "min_bonus"
        case orderCancelTime = "order_cancel_time"
        case reasons = "reasons"
        case sendEfirRadius = "send_efir_radius"
        case supportNumber = "support_number"
        case timeToEfir = "time_to_efir"
        case useBonus = "use_the_bonus"
    }
    
    struct CancelReason: Codable {
        let id: Int
        let name: String
    }
}
