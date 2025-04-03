//
//  NetResRouteCoords.swift
//  Ildam
//
//  Created by applebro on 28/12/23.
//

import Foundation

struct NetResRoute: NetResBody {
    var map: NetResRouteCoords?
    var tariff: [NetResTaxiTariff]
}

struct NetResRouteCoords: Codable {
    var routings: [NetResRouteCoordsItem]
    let distance, duration: Double
    
    enum CodingKeys: String, CodingKey {
        case routings = "routing"
        case distance
        case duration
    }
}

struct NetResRouteCoordsItem: Codable {
    let longitude, latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lng"
        case latitude = "lat"
    }
}
