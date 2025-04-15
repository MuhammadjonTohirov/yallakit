//
//  Coord.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation

public struct Coord: Codable {
    public var lat: Double
    public var lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}
