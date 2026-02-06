//
//  NetReqRateOrder.swift
//  Ildam
//
//  Created by applebro on 08/10/24.
//

import Foundation

struct NetReqRateOrder: Codable {
    let ball: Int
    let orderId: Int
    let comment: String
    let reasonIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case ball
        case orderId = "order_id"
        case comment
        case reasonIds = "rating_reason_ids"
    }
}
