//
//  OrderRoute.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public struct OrderRoute: Codable {
    public let index: Int
    public let fullAddress: String
    public let coords: Coord
    
    public init(index: Int, fullAddress: String, coords: Coord) {
        self.index = index
        self.fullAddress = fullAddress
        self.coords = coords
    }
    
    init?(res: NetResOrderRoute?) {
        guard let res = res else { return nil }
        
        self.coords = .init(lat: res.coords.lat, lng: res.coords.lng)
        self.index = res.index
        self.fullAddress = res.fullAddress
    }
}
