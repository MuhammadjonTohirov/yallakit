//
//  NetResSearchAddress.swift
//  Ildam
//
//  Created by applebro on 22/12/23.
//

import Foundation

struct NetResAddressItem: Codable {
    var lat: Double
    var lng: Double
    var name: String?
    var addressId: Int?
    var addressName: String
    var distance: Double
    var db: Bool
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case addressId = "address_id"
        case name
        case addressName = "address_name"
        case distance
        case db
    }
}

