//
//  OrderRoutingCoordsResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

public struct OrderRoutingCoordsResponse {
    public let distance: Double
    public let duration: Double
    public let routing: [Coordinate]

    public init(distance: Double, duration: Double, routing: [Coordinate]) {
        self.distance = distance
        self.duration = duration
        self.routing = routing
    }

    init(from network: DNetOrderRoutingResponse) {
        self.distance = network.distance
        self.duration = network.duration
        self.routing = network.routing.map { Coordinate(lat: $0.lat, lng: $0.lng) }
    }
}

public struct Coordinate: Codable {
    public let lat: Double
    public let lng: Double

    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}
