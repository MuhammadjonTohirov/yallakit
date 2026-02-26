//
//  CoordinateAddress.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation

public struct CoordinateAddress {
    public let id: Int64?
    public var lat: Double
    public var lng: Double
    public var name: String
    public var distance: Double?
    public var parent: AddressParent?
    public var level: String?
    
    public init(id: Int64?, lat: Double, lng: Double, name: String, distance: Double? = nil, parent: AddressParent? = nil, level: String? = nil) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.name = name
        self.distance = distance
        self.parent = parent
        self.level = level
    }
    
    public typealias AddressParent = Core.AddressParent
}
