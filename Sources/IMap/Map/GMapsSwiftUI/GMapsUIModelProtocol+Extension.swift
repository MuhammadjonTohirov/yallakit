//
//  GMapsUIModelProtocol+Extensions.swift
//  Ildam
//
//  Created by applebro on 01/02/24.
//

import Foundation
import GoogleMaps
import SwiftUI
import Core

public extension GMapsUIModelProtocol {
    func set(isEnabled: Bool) {
        self.isMapEnabled = isEnabled
    }
    
    func set(routeMarkers: [GMSMarker]?) {
        self.routeMarkers = routeMarkers
    }
    
    func set(delegate: GMapsDelegate) {
        self.delegate = delegate
    }
    
    func set(address: String) {
        withAnimation {
            self.pickedAddress = address
        }
    }
    
    func set(pickedLocation location: CLLocation) {
        guard self.state == .normal else {
            return
        }
                
        self.pickedLocation = location
    }
    
    func clearRouteAndMarkers() {
        self.clearRouteMarkers()
        self.routeCoordinates = []
    }
    
    func clearRouteMarkers() {
        self.routeMarkers?.forEach({ marker in
            marker.map = nil
        })
        self.routeMarkers?.removeAll()
    }
    
    func clearRoute() {
        self.routeCoordinates = []
    }
}
