//
//  AddressResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Models/AddressResponse.swift
import Foundation

public struct AddressResponse: Sendable {
    public let id: Int?
    public var lat: Double
    public var lng: Double
    public var name: String
    public var distance: Double?
    public var parent: AddressParent?
    public var level: String?
    
    public init(id: Int?, lat: Double, lng: Double, name: String, distance: Double? = nil, parent: AddressParent? = nil, level: String? = nil) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.name = name
        self.distance = distance
        self.parent = parent
        self.level = level
    }
    
    public struct AddressParent: Sendable {
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

extension AddressResponse {
    init?(response: NetResGetAddress?) {
        guard let response = response else { return nil }
        
        self.id = response.id
        self.lat = response.lat
        self.lng = response.lng
        self.name = response.name
        self.distance = response.distance
        self.level = response.level
        self.parent = response.parent.flatMap { AddressParent(id: $0.id, name: $0.name, lavel: $0.level) }
    }
}
