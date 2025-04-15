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
    
    public init(lat: Double, lng: Double, name: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.id = nil
    }
    
    init?(with: NetResGetAddress?) {
        guard let with = with else {
            return nil
        }
        
        self.id = with.id
        self.lat = with.lat
        self.lng = with.lng
        self.name = with.name
    }
}
