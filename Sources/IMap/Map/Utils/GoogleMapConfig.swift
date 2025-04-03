//
//  GoogleMapConfig.swift
//  IMap
//
//  Created by applebro on 10/09/24.
//

import Foundation
import GoogleMaps

public struct GMSServicesConfig {
    nonisolated(unsafe) private static var didConfig = false
    
    public static func setupAPIKey() {
        guard !didConfig else { return }
        didConfig = true
        GMSServices.provideAPIKey(URL.googleMapsApiKey)
    }
}
