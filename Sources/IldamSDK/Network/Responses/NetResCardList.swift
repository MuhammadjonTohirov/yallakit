//
//  NetResCardList.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 25/11/24.
//

import Foundation

struct NetResCardItem: NetResBody {
    let cardId: String?
    let isDefault: Bool?
    let expiry: String?
    let maskedPan: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case cardId = "card_id"
        case isDefault = "default"
        case expiry
        case maskedPan = "cart_number"
        case createdAt = "created_at"
    }
}
