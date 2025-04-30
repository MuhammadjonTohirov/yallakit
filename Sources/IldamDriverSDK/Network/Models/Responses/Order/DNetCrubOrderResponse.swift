//
//  DNetCrubOrderRess.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI

struct DNetCrubOrderResponse: DNetResBody {
    
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
