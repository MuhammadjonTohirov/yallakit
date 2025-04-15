//
//  NetResGetAddress.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import NetworkLayer

struct NetResGetAddress: NetResBody {
    let id: Int?
    var lat: Double
    var lng: Double
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lng
        case name = "display_name"
    }
}
