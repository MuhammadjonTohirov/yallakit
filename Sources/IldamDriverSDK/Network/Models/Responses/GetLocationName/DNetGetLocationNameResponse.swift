//
//  DNetGetLocationNameResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

struct DNetGetLocationNameResponse: DNetResBody {
    let db: Bool
    let displayName: String
    let distance: Double
    let id: Int?
    let lat: String
    let level: String?
    let lon: String
    let parent: DNetLocationParent?

    enum CodingKeys: String, CodingKey {
        case db
        case displayName = "display_name"
        case distance
        case id
        case lat
        case level
        case lon
        case parent
    }
}

struct DNetLocationParent: Codable {
    let id: Int
    let lat: String
    let lng: String
    let name: String
}
