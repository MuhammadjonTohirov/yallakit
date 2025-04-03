//
//  SelectedAddressItem.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 06/03/25.
//

import Foundation

public struct SecondaryAddressItem {
    public let addressId: Int?
    public let addressName: String?
    public let distance: Double
    public let lat: Double
    public let lng: Double
    public let name: String?
    public let type: String?
    
    public init(addressId: Int? = nil, addressName: String? = nil, distance: Double = 0, lat: Double = 0, lng: Double = 0, name: String? = nil, type: String? = nil) {
        self.addressId = addressId
        self.addressName = addressName
        self.distance = distance
        self.lat = lat
        self.lng = lng
        self.name = name
        self.type = type
    }
}

extension SecondaryAddressItem: Identifiable {
    public var id: Int {
        addressId ?? 0
    }
    
    public var distanceString: String {
        return String(format: "%.1f km", distance)
    }
}

extension SecondaryAddressItem: Equatable {
    public static func == (lhs: SecondaryAddressItem, rhs: SecondaryAddressItem) -> Bool {
        lhs.addressId == rhs.addressId
    }
}

extension SecondaryAddressItem {
    init?(res response: NetResSecondaryAddressItem?) {
        guard let response = response else { return nil }
        self.addressId = response.addressId
        self.addressName = response.addressName
        self.distance = response.distance
        self.lat = response.lat
        self.lng = response.lng
        self.name = response.name
        self.type = response.type
    }
}
