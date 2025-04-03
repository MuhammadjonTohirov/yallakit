//
//  NetResRouteCoords.swift
//  Ildam
//
//  Created by applebro on 28/12/23.
//

import Foundation
import NetworkLayer

struct NetResRouteCoords: NetResBody {
    var routings: [NetResRouteCoordsItem]
    let distance, duration: Double
}

struct NetResRouteCoordsItem: Codable {
    let longitude, latitude: Double
    
    enum CodingKeys: CodingKey {
        case longitude
        case latitude
    }
    
    var isCarLine: Bool = true
}
