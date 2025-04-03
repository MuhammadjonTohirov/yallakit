//
//  NetReqExecutors.swift
//  Ildam
//
//  Created by applebro on 19/01/24.
//

import Foundation

struct NetReqExecutors: Codable {
    // generate struct using json
    let tariffOptions: [Int]
    let tariffId: Int?
    let lat, lng: String
    
    enum CodingKeys: String, CodingKey {
        case tariffOptions = "tariff_options"
        case tariffId = "tariff_id"
        case lat
        case lng
    }
    
    init(tariffOptions: [Int], tariffId: Int?, lat: Double, lng: Double) {
        self.tariffOptions = tariffOptions
        self.tariffId = tariffId
        self.lat = String(lat)
        self.lng = String(lng)
    }
}
