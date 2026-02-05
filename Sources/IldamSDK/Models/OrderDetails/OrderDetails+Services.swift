//
//  OrderDetails+Services.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public struct OrderServiceItem: Codable, Sendable {
    public var cost: Double?
    public var costType: String?
    public var name: String?
    
    public init(cost: Double? = nil, costType: String? = nil, name: String? = nil) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(_ res: NetResOrderService) {
        self.cost = res.cost
        self.costType = res.costType
        self.name = res.name
    }
}

public struct OrderTaxiTrack: Codable, Sendable {
    public var accuracy: Double?
    public var lat: Double?
    public var lng: Double?
    public var locationType: String? // ex: fused
    public var online: Bool?
    public var speed: Double?
    public var status: String? // ex: appointed
    public var time: Int64?
    
    init(res: NetResOrderTaxiTrack) {
        self.accuracy = res.accuracy
        self.lat = res.lat
        self.lng = res.lng
        self.locationType = res.locationType
        self.online = res.online
        self.speed = res.speed
        self.status = res.status
        self.time = res.time
    }
    
    public init(accuracy: Double? = nil, lat: Double? = nil, lng: Double? = nil, locationType: String? = nil, online: Bool? = nil, speed: Double? = nil, status: String? = nil, time: Int64? = nil) {
        self.accuracy = accuracy
        self.lat = lat
        self.lng = lng
        self.locationType = locationType
        self.online = online
        self.speed = speed
        self.status = status
        self.time = time
    }
}
