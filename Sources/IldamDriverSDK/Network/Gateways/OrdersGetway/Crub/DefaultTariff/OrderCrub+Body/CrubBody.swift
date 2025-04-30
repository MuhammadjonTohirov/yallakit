//
//  CrubBody.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

struct CrubBody: Encodable {
    let lat: Double
    let lng: Double
    let tariffId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case tariffId = "tariff_id"
        case name
    }
    init(lat: Double, lng: Double, tariffId: Int, name: String) {
        self.lat = lat
        self.lng = lng
        self.tariffId = tariffId
        self.name = name
    }
}
