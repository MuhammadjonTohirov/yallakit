//
//  DNetPolygonResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

struct DNetPolygonResponse: DNetResBody {
    let id: Int
    let name: String
    let polygon: [DNetPolygonCoordinate]
}

struct DNetPolygonCoordinate: Codable {
    let lat: Double
    let lng: Double
}
