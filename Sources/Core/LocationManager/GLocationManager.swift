//
//  GLocationManager.swift
//  Ildam
//
//  Created by applebro on 27/11/23.
//

import Foundation
import CoreLocation

public class GLocationManager: NSObject, CLLocationManagerDelegate {
    nonisolated(unsafe) public static let shared = GLocationManager()
    public private(set) var locationManager = CLLocationManager()
    public var locationUpdateHandler: ((CLLocation) -> Void)?
    public var statusChangeHandler: ((_ status: CLAuthorizationStatus) -> Void)?
    
    public var currentLocation: CLLocation? {
        locationManager.location
    }
    
    override public init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func startUpdatingLocation() {
        DispatchQueue.global(qos: .utility).async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
                self.postLastLocationNotification()
            } else {
                print("Location services are not enabled.")
                // Handle the case where location services are not enabled.
            }
        }
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            postLastLocationNotification(location)
        }
    }
    
    private func postLastLocationNotification(_ _location: CLLocation? = nil) {
        guard let location = _location ?? self.locationManager.location else { return }
        locationUpdateHandler?(location)
        mainIfNeeded {
            NotificationCenter.default.post(name: NSNotification.Name.currentLocation, object: location)
        }
    }
        
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        statusChangeHandler?(manager.authorizationStatus)
        
        switch manager.authorizationStatus {
        case .authorizedAlways:
            Logging.l("Authorization status: Always allowed")
        case .authorizedWhenInUse:
            Logging.l("Authorization status: In use allowed")
        case .notDetermined:
            Logging.l("Authorization status: Not determend")
        case .denied:
            Logging.l("Authorization status: Denied")
        case .restricted:
            Logging.l("Authorization status: Restricted")
        @unknown default:
            Logging.l("Authorization status: Unknown")
        }
        
    }
}

public struct PlaceInfo {
    public let address: String
    public let latitude: Double
    public let longitude: Double
    
    public init(address: String, latitude: Double, longitude: Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}

public extension NSNotification.Name {
    static var currentLocation: NSNotification.Name {
        .init("currentLocation")
    }
}
