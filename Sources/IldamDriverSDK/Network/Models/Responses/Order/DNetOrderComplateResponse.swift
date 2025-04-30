//
//  DNetOrderComplateResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

struct DNetOrderComplateResponse: DNetResBody {
    let result: DNetOrderComplateResult
}

struct DNetOrderComplateResult: Codable {
    let id: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
    }
}
