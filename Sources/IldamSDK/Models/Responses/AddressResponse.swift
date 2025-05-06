//
//  AddressResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/AddressResponse.swift
import Foundation

public struct AddressResponse {
    public let lat: Double
    public let lng: Double
    public let name: String
    
    public init(lat: Double, lng: Double, name: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
    }
    
    init(networkResponse: NetResGetAddress) {
        self.lat = networkResponse.lat
        self.lng = networkResponse.lng
        self.name = networkResponse.name
    }
}
