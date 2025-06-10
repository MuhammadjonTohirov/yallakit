//
//  DNetSendCoordResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI

public struct SendCoordsBody: Encodable, Sendable {
    let coords: SendCoords?
    let orderCheck: OrderCheck?
    
    enum CodingKeys: String, CodingKey {
        case coords
        case orderCheck = "order_ckeck"
    }
    
    init(coords: SendCoords?, orderCheck: OrderCheck?) {
        self.coords = coords
        self.orderCheck = orderCheck
    }
}

struct SendCoords: Encodable, Sendable {
    let heading: Int
    let lat: Double
    let lng: Double
    let speed: Double
    let orderStatus: String?
    let orderId: Int?
    let online: Bool?
    let statusTime: String?
    
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
}

struct OrderCheck: Encodable, Sendable {
    let coverPrice: Int
    let accountCalculationStatus: Bool
    let distance: Double
    let duration: String
    let fullDistance: String
    let fullDuration: String
    let inCity: DNetLocationZone
    let isWaitingTime: Bool
    let outCity: DNetLocationZone
    let remainderPrice: Int
    let startPrice: Int
    let totalMinutePrice: Int
    let totalPrice: Int
    let tripPrice: Int
    let waitPrice: Int
    let waitTime: String
    
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
}

struct DNetLocationZone: Encodable {
    let distance: Double
    let duration: String
    let waitPrice: Double
    let waitTime: String
    
}
