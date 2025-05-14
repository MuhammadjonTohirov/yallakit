//
//  DNetCardItem.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

struct DNetCardListItem: Codable {
    let cardId: String
    let isDefault: Bool
    let expiry: String
    let maskedPan: String

    enum CodingKeys: String, CodingKey {
        case cardId = "card_id"
        case isDefault = "default"
        case expiry
        case maskedPan = "masked_pan"
    }
}
