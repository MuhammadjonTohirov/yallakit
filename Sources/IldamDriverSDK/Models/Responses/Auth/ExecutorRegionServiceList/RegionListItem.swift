//
//  ExecutorRegionServiceListResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

public struct RegionListItem {
    public let id: Int
    public let name: LocalizedName?
    public let services: [ServiceItem]?

    public init(id: Int, name: LocalizedName?, services: [ServiceItem]?) {
        self.id = id
        self.name = name
        self.services = services
    }
    init(from network: DNetRegionListItem) {
        self.id = network.id
        self.name = network.name.map(LocalizedName.init)
        self.services = network.services?.map(ServiceItem.init)
    }
}

public struct LocalizedName {
    public let uz: String?
    public let ru: String?

    public init(uz: String?, ru: String?) {
        self.uz = uz
        self.ru = ru
    }
    
    init(_ network: DNetLocalizedName) {
        self.uz = network.uz
        self.ru = network.ru
    }
}

public struct ServiceItem {
    public let id: Int
    public let name: LocalizedName?

    public init(id: Int, name: LocalizedName?) {
        self.id = id
        self.name = name
    }
    
    init(_ network: DNetServiceItem) {
        self.id = network.id
        self.name = network.name.map(LocalizedName.init)
    }
}
