//
//  NetResMyAddressItem.swift
//  Ildam
//
//  Created by applebro on 24/12/23.
//

import Foundation
import Core

struct NetResMyAddressItem: NetResBody {
    let id: Int
    let name: String
    let address: String
    let coords: NetCoord
    let type: MyAddressType?
    let enter: String?
    let apartment: String?
    let floor: String?
    let comment: String?
    
    /// created_at
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case coords
        case type
        case enter
        case apartment
        case floor
        case comment
        case createdAt = "created_at"
    }
}


