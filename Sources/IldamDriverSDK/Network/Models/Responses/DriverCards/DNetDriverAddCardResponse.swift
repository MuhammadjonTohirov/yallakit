//
//  Dnd.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

struct DNetAddCardRequest: Encodable {
    let number: String
    let expiry: String
}

struct DNetDriverAddCardResponse: DNetResBody {
    let expiry: String
    let key: String
    let number: String
    let phone: String
    
}

