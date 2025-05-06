//
//  sdsad.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

public struct CardAddedResponse {
    public let expiry: String
    public let key: String
    public let number: String
    public let phone: String

    public init(expiry: String, key: String, number: String, phone: String) {
        self.expiry = expiry
        self.key = key
        self.number = number
        self.phone = phone
    }

    init(from network: DNetDriverAddCardResponse) {
        self.expiry = network.expiry
        self.key = network.key
        self.number = network.number
        self.phone = network.phone
    }
}
