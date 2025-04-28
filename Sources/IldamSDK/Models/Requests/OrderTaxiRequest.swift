//
//  TaxiOrderRequest.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation

public struct OrderTaxiRequest: Codable {
    public var addresses: [TaxiOrderAddressItem]
    public var comment: String
    public var dontCallMe: Bool
    public var fixedPrice: Bool
    public var paymentType: String
    public var service: String
    public var tariffID: Int
    public var tariffOptions: [Int]
    public var toPhone: String
    public var addressId: Int?
    public var bonusAmount: Int?
    
    enum CodingKeys: String, CodingKey {
        case addresses = "addresses"
        case comment = "comment"
        case dontCallMe = "dont_call_me"
        case fixedPrice = "fixed_price"
        case paymentType = "payment_type"
        case service = "service"
        case tariffID = "tariff_id"
        case tariffOptions = "tariff_options"
        case toPhone = "to_phone"
        case addressId = "address_id"
        case bonusAmount = "bonus_amount"
    }
    
    public init(addresses: [TaxiOrderAddressItem], comment: String, dontCallMe: Bool, fixedPrice: Bool, paymentType: String, service: String, tariffID: Int, tariffOptions: [Int], toPhone: String, addressId: Int? = nil, bonusAmount: Int? = nil) {
        self.addresses = addresses
        self.comment = comment
        self.dontCallMe = dontCallMe
        self.fixedPrice = fixedPrice
        self.paymentType = paymentType
        self.service = service
        self.tariffID = tariffID
        self.tariffOptions = tariffOptions
        self.toPhone = toPhone
        self.addressId = addressId
        self.bonusAmount = bonusAmount
    }
}

public struct TaxiOrderItem: Codable {
    public var orderId: Int?
    public var result: OrderDetails?
    
    public init(orderId: Int? = nil, result: OrderDetails? = nil) {
        self.orderId = orderId
        self.result = result
    }
}

public struct TaxiOrderAddressItem: Codable {
    public let id: Int?
    public let lat: Double
    public let lng: Double
    public let name: String
    
    public init(id: Int?, lat: Double, lng: Double, name: String) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.name = name
    }
}
