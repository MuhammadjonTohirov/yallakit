//
//  DNetOrderComplateResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

struct DNetOrderComplateResult: DNetResBody {
    let id: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
    }
}
