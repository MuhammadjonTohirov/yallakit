//
//  DNetOrderRoutingRequest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

// MARK: - Request Body
public struct DNetOrderRoutingPoint: Encodable {
    let lat: Double
    let lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Response Body
struct DNetOrderRoutingResponse: DNetResBody {
    let distance: Double
    let duration: Double
    let routing: [DNetRoutingPoint]
    
    struct DNetRoutingPoint: Codable {
        let lat: Double
        let lng: Double
    }
}
