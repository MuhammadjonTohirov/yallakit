//
//  GoogleMapConfig.swift
//  IMap
//
//  Created by applebro on 10/09/24.
//

import Foundation
import GoogleMaps

public struct GMSServicesConfig: Sendable {
    @MainActor static var didConfig = false
    
    /// - key: default if nill or empty
    /// - Once the config is set second time will not be initialized due to confition check
    @MainActor
    public static func setupAPIKey(_ key: String? = nil) {
        guard !didConfig else { return }
        didConfig = true
        GMSServices.provideAPIKey(key?.nilIfEmpty ?? URL.googleMapsApiKey)
    }
}
