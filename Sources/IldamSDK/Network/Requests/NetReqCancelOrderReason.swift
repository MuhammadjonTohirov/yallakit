//
//  NetResCanselOrderReason.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 10/12/24.
//

import Foundation

struct NetReqCancelOrderReason: Codable {
    let reasonId: Int
    let reasonComment: String
    
    enum CodingKeys: String, CodingKey {
        case reasonId = "reason_id"
        case reasonComment = "reason_comment"
    }
}
