//
//  DNetOrderAppointedOfferResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI

struct DNetOrderSkipResponse: DNetResBody {
    
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
