//
//  SearchAddressItem.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/SearchAddressResponse.swift
import Foundation

public struct SearchAddressItem: Sendable {
    public let lat: Double
    public let lng: Double
    public let name: String?
    public let addressId: Int?
    public let addressName: String
    public let distance: Double
    public let isInDatabase: Bool
    
    public init(lat: Double, lng: Double, name: String?, addressId: Int?, addressName: String, distance: Double, isInDatabase: Bool) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.addressId = addressId
        self.addressName = addressName
        self.distance = distance
        self.isInDatabase = isInDatabase
    }
    
    init(networkResponse: NetResAddressItem) {
        self.lat = networkResponse.lat
        self.lng = networkResponse.lng
        self.name = networkResponse.name
        self.addressId = networkResponse.addressId
        self.addressName = networkResponse.addressName
        self.distance = networkResponse.distance
        self.isInDatabase = networkResponse.db
    }
}
