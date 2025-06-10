//
//  DNetSendCoordResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI

public struct SendCoordsBody: Encodable, Sendable {
    public let coords: SendCoords?
    public let orderCheck: OrderCheck?
    
    enum CodingKeys: String, CodingKey {
        case coords
        case orderCheck = "order_ckeck"
    }
    
    public init(coords: SendCoords?, orderCheck: OrderCheck?) {
        self.coords = coords
        self.orderCheck = orderCheck
    }
}

public struct SendCoords: Encodable, Sendable {
    public let heading: Int
    public let lat: Double
    public let lng: Double
    public let speed: Double
    public let orderStatus: String?
    public let orderId: Int?
    public let online: Bool?
    public let statusTime: String?
    
    enum CodingKeys: String, CodingKey {
        case heading
        case lat
        case lng
        case speed
        case orderStatus = "order_status"
        case orderId = "order_id"
        case online
        case statusTime = "status_time"
    }
    
    public init(heading: Int, lat: Double, lng: Double, speed: Double, orderStatus: String?, orderId: Int?, online: Bool?, statusTime: String?) {
        self.heading = heading
        self.lat = lat
        self.lng = lng
        self.speed = speed
        self.orderStatus = orderStatus
        self.orderId = orderId
        self.online = online
        self.statusTime = statusTime
    }
}

public struct OrderCheck: Encodable, Sendable {
    public let coverPrice: Int
    public let accountCalculationStatus: Bool
    public let distance: Double
    public let duration: String
    public let fullDistance: String
    public let fullDuration: String
    public let inCity: LocationZone
    public let isWaitingTime: Bool
    public let outCity: LocationZone
    public let remainderPrice: Int
    public let startPrice: Int
    public let totalMinutePrice: Int
    public let totalPrice: Int
    public let tripPrice: Int
    public let waitPrice: Int
    public let waitTime: String
    
    enum CodingKeys: String, CodingKey {
        case coverPrice = "cover_price"
        case accountCalculationStatus = "account_calculation_status"
        case distance
        case duration
        case fullDistance = "full_distance"
        case fullDuration = "full_duration"
        case inCity = "in_city"
        case isWaitingTime = "is_waiting_time"
        case outCity = "out_city"
        case remainderPrice = "remainder_price"
        case startPrice = "start_price"
        case totalMinutePrice = "total_minute_price"
        case totalPrice = "total_price"
        case tripPrice = "trip_price"
        case waitPrice = "wait_price"
        case waitTime = "wait_time"
    }
    
    public init(coverPrice: Int, accountCalculationStatus: Bool, distance: Double, duration: String, fullDistance: String, fullDuration: String, inCity: LocationZone, isWaitingTime: Bool, outCity: LocationZone, remainderPrice: Int, startPrice: Int, totalMinutePrice: Int, totalPrice: Int, tripPrice: Int, waitPrice: Int, waitTime: String) {
        self.coverPrice = coverPrice
        self.accountCalculationStatus = accountCalculationStatus
        self.distance = distance
        self.duration = duration
        self.fullDistance = fullDistance
        self.fullDuration = fullDuration
        self.inCity = inCity
        self.isWaitingTime = isWaitingTime
        self.outCity = outCity
        self.remainderPrice = remainderPrice
        self.startPrice = startPrice
        self.totalMinutePrice = totalMinutePrice
        self.totalPrice = totalPrice
        self.tripPrice = tripPrice
        self.waitPrice = waitPrice
        self.waitTime = waitTime
    }
}

struct DNetLocationZone: Encodable {
    let distance: Double
    let duration: String
    let waitPrice: Double
    let waitTime: String
}

public struct LocationZone: Encodable, Sendable {
    public let distance: Double
    public let duration: String
    public let waitPrice: Double
    public let waitTime: String
    
    public init(distance: Double, duration: String, waitPrice: Double, waitTime: String) {
        self.distance = distance
        self.duration = duration
        self.waitPrice = waitPrice
        self.waitTime = waitTime
    }
}

extension LocationZone {
    var asReq: DNetLocationZone {
        .init(distance: distance, duration: duration, waitPrice: waitPrice, waitTime: waitTime)
    }
}
