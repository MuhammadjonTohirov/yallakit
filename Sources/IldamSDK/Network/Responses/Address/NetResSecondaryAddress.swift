//
//  NetResSecondaryAddressItem.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 06/03/25.
//

import Foundation

struct NetResSecondaryAddressItem: Codable {
    let addressId: Int?
    let addressName: String?
    let uniqueId: Int?
    let distance: Double
    let lat: Double
    let lng: Double
    let name: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case uniqueId = "unique_id"
        case addressName = "address_name"
        case distance
        case lat
        case lng
        case name
        case type
    }
}
