//
//  NetResGetAddress.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import NetworkLayer

struct NetResGetAddress: NetResBody {
    let id: Int64?
    var lat: Double
    var lng: Double
    var name: String
    var distance: Double?
    var parent: AddressParent?
    var level: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lng
        case name = "display_name"
        case distance
        case level
        case parent
    }
    
    struct AddressParent: Codable {
        var id: Int64
        var name: String?
        var level: String?
    }
}
