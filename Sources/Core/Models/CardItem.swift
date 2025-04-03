//
//  CardItem.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 27/03/25.
//

import Foundation

public final class CardItem: NSObject {
    public var cardId: String
    public var isDefault: Bool
    public var expiry: String
    public var maskedPan: String
    
    public init(cardId: String, isDefault: Bool, expiry: String, maskedPan: String) {
        self.cardId = cardId
        self.isDefault = isDefault
        self.expiry = expiry
        self.maskedPan = maskedPan
    }
    
    public static func == (lhs: CardItem, rhs: CardItem) -> Bool {
        return lhs.cardId == rhs.cardId
    }
}
