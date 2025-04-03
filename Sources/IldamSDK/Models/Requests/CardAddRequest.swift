//
//  AddCardRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/CardAddRequest.swift
import Foundation

public struct CardAddRequest {
    public let cardNumber: String
    public let expiry: String
    
    public init(cardNumber: String, expiry: String) {
        self.cardNumber = cardNumber
        self.expiry = expiry
    }
}
