//
//  NetResOrderHistory.swift
//  Ildam
//
//  Created by applebro on 19/01/24.
//

import Foundation

struct NetResOrderHistory: NetResBody {
    let list: [NetResOrderDetails]
    
    init(list: [NetResOrderDetails]) {
        self.list = list
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.list, forKey: .list)
    }
    
    enum CodingKeys: CodingKey {
        case list
        case pagination
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decodeIfPresent([NetResOrderDetails].self, forKey: .list) ?? []
    }
}

struct NetResOrderRoute: Codable {
    struct Coords: Codable {
        let lat: Double?
        let lng: Double?
    }

    let index: Int?
    let fullAddress: String?
    let coords: Coords?

    enum CodingKeys: String, CodingKey {
        case index
        case fullAddress = "full_address"
        case coords
    }
}
