//
//  SelectedAddressItem.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 06/03/25.
//

import Foundation


public struct SecondaryAddressParentItem {
    public let id: Int?
    public let name: String?
    
    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
 
public struct SecondaryAddressItem {
    
    public let uniqueId: Int?
    public let addressId: Int?
    public let name: String?
    public let addressName: String?
    public let type: String?
    public let lat: Double
    public let lng: Double
    public let distance: Double
    public let duration: Double
    public let parent: SecondaryAddressParentItem?
    
    public init(uniqueId: Int?, addressId: Int?, name: String?, addressName: String ,type: String?, lat: Double, lng: Double, distance: Double, duration: Double, parent: SecondaryAddressParentItem?) {
        self.uniqueId = uniqueId
        self.addressId = addressId
        self.name = name
        self.addressName = addressName
        self.type = type
        self.lat = lat
        self.lng = lng
        self.distance = distance
        self.duration = duration
        self.parent = SecondaryAddressParentItem(id: parent?.id, name: parent?.name)
    }
}

extension SecondaryAddressItem: Identifiable {
    public var id: Int {
        uniqueId ?? 0
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

        self.uniqueId = response.uniqueId
        self.addressId = response.addressId
        self.name = response.name
        self.addressName = response.addressName
        self.type = response.type
        self.lat = response.lat
        self.lng = response.lng
        self.distance = response.distance ?? 0
        self.duration = response.duration ?? 0
        self.parent = SecondaryAddressParentItem(id: response.parent?.id ?? 0, name: response.parent?.name ?? "")
    }
}

extension SecondaryAddressParentItem {
    init?(res response: NetResAddressParent?) {
        guard let response = response else { return nil }
        
        self.id = response.id
        self.name = response.name
    }
}
