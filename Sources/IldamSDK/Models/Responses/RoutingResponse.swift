//
//  RoutingResponse.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 23/12/25.
//

import Foundation
import Core

public struct RoutingResponse: NetResBody, Sendable {
    public let distance: Double
    public let duration: Double
    public let routing: [Coord]
    
    public init(distance: Double, duration: Double, routing: [Coord]) {
        self.distance = distance
        self.duration = duration
        self.routing = routing
    }
}
