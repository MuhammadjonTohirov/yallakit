//
//  DriverCardItem.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public struct DriverCardListItem {
    public let cardId: String
    public let isDefault: Bool
    public let expiry: String
    public let maskedPan: String

    public init(
        cardId: String,
        isDefault: Bool,
        expiry: String,
        maskedPan: String
    ) {
        self.cardId = cardId
        self.isDefault = isDefault
        self.expiry = expiry
        self.maskedPan = maskedPan
    }

    init(from network: DNetCardListItem) {
        self.cardId = network.cardId
        self.isDefault = network.isDefault
        self.expiry = network.expiry
        self.maskedPan = network.maskedPan
    }
}
