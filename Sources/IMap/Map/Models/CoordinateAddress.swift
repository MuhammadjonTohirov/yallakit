//
//  CoordinateAddress.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation

public struct CoordinateAddress {
    public let id: Int?
    public var lat: Double
    public var lng: Double
    public var name: String
    public var distance: Double?
    public var parent: AddressParent?
    public var level: String?
    
    public init(id: Int?, lat: Double, lng: Double, name: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.id = id
    }
    
    init?(with: NetResGetAddress?) {
        guard let with = with else {
            return nil
        }
        
        self.id = with.id
        self.lat = with.lat
        self.lng = with.lng
        self.name = with.name
        self.distance = with.distance
        self.parent = with.parent.map({.init(id: $0.id, name: $0.name, lavel: $0.level)})
        self.level = with.level
    }
    
    public struct AddressParent {
        public var id: Int
        public var name: String?
        public var level: String?
        
        public init(id: Int, name: String? = nil, lavel: String? = nil) {
            self.id = id
            self.name = name
            self.level = lavel
        }
    }
}
