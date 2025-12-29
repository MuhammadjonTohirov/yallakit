//
//  CardItem.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 27/03/25.
//

import Foundation

public struct CardItem: Sendable {
    public var cardId: String?
    public var isDefault: Bool?
    public var expiry: String?
    public var maskedPan: String
    public var createdAt: String?
    
    public init(cardId: String? = nil, isDefault: Bool? = nil, expiry: String? = nil, maskedPan: String = "", createdAt: String? = nil) {
        self.cardId = cardId
        self.isDefault = isDefault
        self.expiry = expiry
        self.maskedPan = maskedPan
        self.createdAt = createdAt
    }
    
    public static func == (lhs: CardItem, rhs: CardItem) -> Bool {
        return lhs.cardId == rhs.cardId
    }
}
