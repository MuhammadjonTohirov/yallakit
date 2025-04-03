//
//  NetResOrderTaxi.swift
//  Ildam
//
//  Created by applebro on 25/01/24.
//

import Foundation

struct NetResOrderTaxi: NetResBody {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "order_id"
    }
}
