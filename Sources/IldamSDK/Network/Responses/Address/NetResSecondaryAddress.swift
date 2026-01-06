//
//  NetResSecondaryAddressItem.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 06/03/25.
//

import Foundation

struct NetResSecondaryAddressResult: NetResBody {
    let items: [NetResSecondaryAddressItem]
}

struct NetResAddressParent: Codable {
    let id: Int64?
    let name: String?
}
struct NetResSecondaryAddressItem: Codable {
    let uniqueId: Int64?
    let addressId: Int64?
    let addressName: String?
    let name: String?
    let type: String?
    let lat: Double
    let lng: Double
    let distance: Double?
    let duration: Double?
    let parent: NetResAddressParent?
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case addressId = "address_id"
        case name
        case addressName = "address_name" 
        case type
        case lat
        case lng
        case distance
        case duration
        case parent
    }
}
