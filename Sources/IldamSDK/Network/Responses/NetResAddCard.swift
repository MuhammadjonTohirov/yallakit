//
//  NetResAddCard.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 23/11/24.
//

import Foundation

struct NetResAddCard: NetResBody {
    let expiry: String?
    let key: String?
    let cardNumber: String?
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case expiry
        case key
        case cardNumber = "number"
        case phone
    }
}
