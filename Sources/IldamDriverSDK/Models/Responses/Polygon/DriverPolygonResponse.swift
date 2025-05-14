//
//  DriverPolygonResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import SwiftUI

public struct DriverPolygonResponse {
    public let id: Int
    public let name: String
    public let polygon: [DriverPolygonCoordinate]

    public init(id: Int, name: String, polygon: [DriverPolygonCoordinate]) {
        self.id = id
        self.name = name
        self.polygon = polygon
    }

    init(from network: DNetPolygonResponse) {
        self.id = network.id
        self.name = network.name
        self.polygon = network.polygon.map { DriverPolygonCoordinate(lat: $0.lat, lng: $0.lng) }
    }
}

public struct DriverPolygonCoordinate: Codable {
    public let lat: Double
    public let lng: Double

    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}
