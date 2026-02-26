//
//  NetResPolygonItem.swift
//  Core
//
//  Created by applebro on 11/09/24.
//

import Foundation

struct NetResPolygonItem: Codable {
    let addressID: Int
    let polygon: [NetCoord]
    let config: NetResPolygonConfig?

    enum CodingKeys: String, CodingKey {
        case addressID = "address_id"
        case polygon
        case config
    }

    struct NetResPolygonConfig: Codable {
        let isWorkingMobile: Bool?
        let notServeMessageRu: String?
        let notServeMessageUz: String?
        let notServeMessageEn: String?

        enum CodingKeys: String, CodingKey {
            case isWorkingMobile = "is_working_mobile"
            case notServeMessageRu = "not_serve_message_ru"
            case notServeMessageUz = "not_serve_message_uz"
            case notServeMessageEn = "not_serve_message_en"
        }
    }
}

@available(*, deprecated, renamed: "NetResPolygonItem")
typealias NetResPolygoneItem = NetResPolygonItem

@available(*, deprecated, renamed: "NetResPolygonConfig")
typealias NetResPolygoneConfig = NetResPolygonItem.NetResPolygonConfig

struct NetCoord: Codable {
    let lat: Double
    let lng: Double
}
