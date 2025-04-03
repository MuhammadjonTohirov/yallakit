//
//  CLLocation+Extensions.swift
//  Ildam
//
//  Created by applebro on 26/12/23.
//

import Foundation
import CoreLocation

public extension CLLocation {
    var identifier: String {
        return self.coordinate.identifer
    }
}

public extension CLLocationCoordinate2D {
    var identifer: String {
        return "\(self.latitude)-\(self.longitude)"
    }
}
