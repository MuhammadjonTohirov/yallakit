//
//  ExecutorCardWithdrawRequest.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public struct ExecutorCardWithdrawRequest: Encodable {
    public let cardId: String
    public let amount: Int

    enum CodingKeys: String, CodingKey {
        case cardId = "card_id"
        case amount
    }

    public init(cardId: String, amount: Int) {
        self.cardId = cardId
        self.amount = amount
    }
}
