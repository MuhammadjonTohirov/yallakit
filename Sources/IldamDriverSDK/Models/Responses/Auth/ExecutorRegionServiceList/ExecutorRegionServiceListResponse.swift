//
//  ExecutorRegionServiceListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

public struct ExecutorRegionServiceListResponse {
    public let id: Int
    public let name: RegionName?
    public let services: [Int]?

    public init(id: Int, name: RegionName?, services: [Int]?) {
        self.id = id
        self.name = name
        self.services = services
    }

    init(from network: DNetRegionItem) {
        self.id = network.id
        self.name = network.name.map { RegionName(from: $0) }
        self.services = network.services
    }
}

public struct RegionName {
    public let uz: String?
    public let ru: String?

    public init(uz: String?, ru: String?) {
        self.uz = uz
        self.ru = ru
    }

    init(from network: DNetRegionItem.DNetRegionName) {
        self.uz = network.uz
        self.ru = network.ru
    }
}
