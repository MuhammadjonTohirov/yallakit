//
//  CardAddResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation

public struct CardAddResponse {
    public let expiry: String?
    public let key: String?
    public let cardNumber: String?
    public let phone: String?
    
    init(networkResponse: NetResAddCard) {
        self.expiry = networkResponse.expiry
        self.key = networkResponse.key
        self.cardNumber = networkResponse.cardNumber
        self.phone = networkResponse.phone
    }
    
    public init (expiry: String, key: String, cardNumber: String, phone: String) {
        self.expiry = expiry
        self.key = key
        self.cardNumber = cardNumber
        self.phone = phone
    }
}
