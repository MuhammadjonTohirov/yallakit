//
//  CarSimulator.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 26/01/25.
//

import Foundation
import CoreLocation

struct CarSimulator {
    let waypoints: [CLLocationCoordinate2D]
    let speed: Double // Speed in km/h

    func calculatePosition(for elapsedTime: TimeInterval) -> CLLocationCoordinate2D? {
        // Convert speed to meters per second
        let speedMetersPerSecond = speed * 1000 / 3600
        let totalDistanceTraveled = speedMetersPerSecond * elapsedTime
        
        var accumulatedDistance: Double = 0.0
        
        for i in 0..<waypoints.count - 1 {
            let start = waypoints[i]
            let end = waypoints[i + 1]
            
            // Calculate the distance between the current segment's waypoints
            let segmentDistance = start.distance(to: end)
            
            // Check if the total distance traveled falls within the current segment
            if accumulatedDistance + segmentDistance >= totalDistanceTraveled {
                // Calculate the remaining distance within the segment
                let distanceInSegment = totalDistanceTraveled - accumulatedDistance
                let fraction = distanceInSegment / segmentDistance
                
                // Interpolate the position in the current segment
                let interpolatedLat = start.latitude + fraction * (end.latitude - start.latitude)
                let interpolatedLon = start.longitude + fraction * (end.longitude - start.longitude)
                return CLLocationCoordinate2D(latitude: interpolatedLat, longitude: interpolatedLon)
            }
            
            accumulatedDistance += segmentDistance
        }
        
        // If the total distance exceeds the path length, return the last waypoint
        return waypoints.last
    }
}

extension CLLocationCoordinate2D {
    func distance(to other: CLLocationCoordinate2D) -> Double {
        let earthRadius = 6371000.0 // Earth radius in meters
        let lat1 = self.latitude.toRadians()
        let lon1 = self.longitude.toRadians()
        let lat2 = other.latitude.toRadians()
        let lon2 = other.longitude.toRadians()
        
        let dLat = lat2 - lat1
        let dLon = lon2 - lon1
        let a = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return earthRadius * c
    }
}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}
