//
//  LocationNameResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation

public struct LocationNameResponse {
    public let db: Bool
    public let displayName: String
    public let distance: Double
    public let id: Int
    public let lat: String
    public let level: String
    public let lon: String
    public let parent: LocationParent

    init(from network: DNetGetLocationNameResponse) {
        self.db = network.db
        self.displayName = network.displayName
        self.distance = network.distance
        self.id = network.id ?? 0
        self.lat = network.lat
        self.level = network.level ?? ""
        self.lon = network.lon
        self.parent = network.parent.map(LocationParent.init) ?? LocationParent(id: 0, lat: "", lng: "", name: "")
    }

    public init(
        db: Bool,
        displayName: String,
        distance: Double,
        id: Int,
        lat: String,
        level: String,
        lon: String,
        parent: LocationParent
    ) {
        self.db = db
        self.displayName = displayName
        self.distance = distance
        self.id = id
        self.lat = lat
        self.level = level
        self.lon = lon
        self.parent = parent
    }
}

public struct LocationParent: Codable {
    public let id: Int
    public let lat: String
    public let lng: String
    public let name: String

    public init(id: Int, lat: String, lng: String, name: String) {
        self.id = id
        self.lat = lat
        self.lng = lng
        self.name = name
    }

    init(from network: DNetLocationParent) {
        self.id = network.id
        self.lat = network.lat
        self.lng = network.lng
        self.name = network.name
    }
}
