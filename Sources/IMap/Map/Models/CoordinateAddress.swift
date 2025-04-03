//
//  CoordinateAddress.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation

public struct CoordinateAddress {
    public var lat: String
    public var lng: String
    public var name: String
    
    public init(lat: String, lng: String, name: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
    }
    
    init?(with: NetResGetAddress?) {
        guard let with = with else {
            return nil
        }
        
        self.lat = with.lat
        self.lng = with.lng
        self.name = with.name
    }
}
