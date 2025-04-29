//
//  NetReqOrderTaxi.swift
//  Ildam
//
//  Created by applebro on 25/01/24.
//

import Foundation

struct NetReqOrderTaxi: Codable {
    let addresses: [NetReqOrderTaxiAddress]
    var comment: String
    var dontCallMe: Bool
    var fixedPrice: Bool
    var paymentType: String
    var service: String
    var tariffID: Int
    var tariffOptions: [Int]
    var toPhone: String
    var addressId: Int?
    var bonusAmount: Int?
    var cardId: String?

    
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
        case cardId = "card_id"
    }
    
    init(addresses: [NetReqOrderTaxiAddress], comment: String, dontCallMe: Bool, fixedPrice: Bool, paymentType: String, service: String, tariffID: Int, tariffOptions: [Int], toPhone: String, bonusAmount: Int? = nil, cardId: String? = nil) {
        self.addresses = addresses
        self.comment = comment
        self.dontCallMe = dontCallMe
        self.fixedPrice = fixedPrice
        self.paymentType = paymentType
        self.service = service
        self.tariffID = tariffID
        self.tariffOptions = tariffOptions
        self.bonusAmount = bonusAmount
        self.toPhone = toPhone
        self.cardId = cardId
    }
    
    init(model: OrderTaxiRequest) {
        self.addresses = model.addresses.map({NetReqOrderTaxiAddress(addressId: $0.id, lat: $0.lat, lng: $0.lng, name: $0.name)})
        self.comment = model.comment
        self.dontCallMe = model.dontCallMe
        self.fixedPrice = model.fixedPrice
        self.paymentType = model.paymentType
        self.service = model.service
        self.tariffID = model.tariffID
        self.tariffOptions = model.tariffOptions
        self.toPhone = model.toPhone
        self.addressId = model.addressId
        self.bonusAmount = model.bonusAmount
        self.cardId = model.cardId
    }
}

struct NetReqOrderTaxiAddress: Codable {
    let addressId: Int?
    let lat: Double
    let lng: Double
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case lat = "lat"
        case lng = "lng"
        case name = "name"
    }
}

