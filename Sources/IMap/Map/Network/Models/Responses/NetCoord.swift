//
//  NetCoord.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation

struct NetReqTaxiTariff: Codable {
    let coords: [NetCoord]
    let optionIDS: [Int]
    let tariffID: Int

    enum CodingKeys: String, CodingKey {
        case coords
        case optionIDS = "option_ids"
        case tariffID = "tariff_id"
    }
    
    init(coords: [NetCoord], optionIDS: [Int] = [0], tariffID: Int = 0) {
        self.coords = coords
        self.optionIDS = optionIDS
        self.tariffID = tariffID
    }
    
    init(lat: Double, lng: Double) {
        self.init(coords: [NetCoord(lat: "\(lat)", lng: "\(lng)")])
    }
}

// MARK: - Coord
struct NetCoord: Codable {
    let lat, lng: String
    
    var latFloat: Float {
        Float(lat) ?? 0
    }
    
    var lngFloat: Float {
        Float(lng) ?? 0
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let _lat = try? container.decode(String.self, forKey: .lat)
        let _lng = try? container.decode(String.self, forKey: .lng)
        
        if let lat = _lat, let lng = _lng {
            self.lat = lat
            self.lng = lng
        } else {
            let lat = try container.decode(Double.self, forKey: .lat)
            let lng = try container.decode(Double.self, forKey: .lng)
            self.lat = "\(lat)"
            self.lng = "\(lng)"
        }
    }
    
    enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    
    init(lat: Double, lng: Double) {
        self.init(lat: "\(lat)", lng: "\(lng)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lng, forKey: .lng)
    }
}
