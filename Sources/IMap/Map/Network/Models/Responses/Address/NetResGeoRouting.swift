//
//  NetResGeoRouting.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import CoreLocation

struct NetResGeoRouting: Codable {
    let code: String
    let routes: [GeoRoute]
}

// MARK: - Route
struct GeoRoute: Codable {
    let legs: [GeoLeg]
    let distance, duration: Double
}

// MARK: - Leg
struct GeoLeg: Codable {
    let steps: [GeoStep]
}

// MARK: - Step
struct GeoStep: Codable {
    let geometry: GeoGeometry
}

// MARK: - Geometry
struct GeoGeometry: Codable {
    let coordinates: [[Double]]
    let type: String
}

extension GeoGeometry {
    var locations: [CLLocation] {
        return coordinates.map { CLLocation(latitude: $0.first ?? 0, longitude: $0.last ?? 0) }
    }
}

