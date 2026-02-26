//
//  PolygonItem.swift
//  Core
//
//  Created by applebro on 11/09/24.
//

import Foundation

public struct PolygonItem {
    public let addressID: Int
    public let polygon: [(lat: Double, lng: Double)]
    public var config: PolygonConfig?

    public init(addressID: Int, polygon: [(lat: Double, lng: Double)], config: PolygonConfig? = nil) {
        self.addressID = addressID
        self.polygon = polygon
        self.config = config
    }

    public struct PolygonConfig {
        let isWorkingMobile: Bool?
        let notServeMessageRu: String?
        let notServeMessageUz: String?
        let notServeMessageEn: String?
    }

    @available(*, deprecated, renamed: "PolygonConfig")
    public typealias PolygoneConfig = PolygonConfig
}

extension PolygonItem.PolygonConfig {
    init?(res: NetResPolygonItem.NetResPolygonConfig?) {
        guard let res else { return nil }
        self.isWorkingMobile = res.isWorkingMobile
        self.notServeMessageEn = res.notServeMessageEn
        self.notServeMessageRu = res.notServeMessageRu
        self.notServeMessageUz = res.notServeMessageUz
    }
}
