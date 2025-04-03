//
//  AddressResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/AddressResponse.swift
import Foundation

public struct AddressResponse {
    public let lat: String
    public let lng: String
    public let name: String
    
    public init(lat: String, lng: String, name: String) {
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
