//
//  GRoutePoint.swift
//  Core
//
//  Created by Muhammadjon Tohirov on 27/03/25.
//

import Foundation
import CoreLocation

public struct GRoutePoint: Codable, Identifiable, Hashable {
    /// the same order
    public var id: String {
        location.identifier
    }
    
    public var order: Int
    public var location: CLLocation
    public var address: String
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public init(order: Int, location: CLLocation, address: String) {
        self.order = order
        self.location = location
        self.address = address
    }
    
    public static func == (lhs: GRoutePoint, rhs: GRoutePoint) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case order
        case lat
        case lng
        case address
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
        try container.encode(address, forKey: .address)
        try container.encode(location.coordinate.latitude, forKey: .lat)
        try container.encode(location.coordinate.longitude, forKey: .lng)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.order = try container.decode(Int.self, forKey: .order)
        self.address = try container.decode(String.self, forKey: .address)
        let lat = try container.decode(Double.self, forKey: .lat)
        let lng = try container.decode(Double.self, forKey: .lng)
        self.location = CLLocation(latitude: lat, longitude: lng)
    }
}
