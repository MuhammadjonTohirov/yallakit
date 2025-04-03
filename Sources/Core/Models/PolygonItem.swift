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
    public var config: PolygoneConfig?
    
    public init(addressID: Int, polygon: [(lat: Double, lng: Double)], config: PolygoneConfig? = nil) {
        self.addressID = addressID
        self.polygon = polygon
        self.config = config
    }
    
    public struct PolygoneConfig {
        let isWorkingMobile: Bool?
        let notServeMessageRu: String?
        let notServeMessageUz: String?
        let notServeMessageEn: String?
    }
}

extension PolygonItem.PolygoneConfig {
    init?(res: NetResPolygoneItem.NetResPolygoneConfig?) {
        guard let res else { return nil }
        self.isWorkingMobile = res.isWorkingMobile
        self.notServeMessageEn = res.notServeMessageEn
        self.notServeMessageRu = res.notServeMessageRu
        self.notServeMessageUz = res.notServeMessageUz
    }
}
