//
//  TripCalculationBody.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

struct TripCalculationBody: Encodable {
    let taxiOrder: TaxiOrder

    enum CodingKeys: String, CodingKey {
        case taxiOrder = "taxi_order"
    }

    init(taxiOrder: TaxiOrder) {
        self.taxiOrder = taxiOrder
    }
}

struct TaxiOrder: Encodable {
    let distance: Double
    let duration: String
    let startPrice: Int
    let remainderPrice: Int
    let totalPrice: Int
    let track: [TripTrack]
    let tripPrice: Int
    let fullDuration: String
    let fullDistance: String
    let totalMinutePrice: Int
    let tripMinPrice: Int
    let waitPrice: Int
    let clientPayment: Int
    let waitTime: String
    let inCity: TripZone
    let outCity: TripZone

    enum CodingKeys: String, CodingKey {
        case distance, duration
        case startPrice = "start_price"
        case remainderPrice = "remainder_price"
        case totalPrice = "total_price"
        case track
        case tripPrice = "trip_price"
        case fullDuration = "full_duration"
        case fullDistance = "full_distance"
        case totalMinutePrice = "total_minute_price"
        case tripMinPrice = "trip_min_price"
        case waitPrice = "wait_price"
        case clientPayment = "client_payment"
        case waitTime = "wait_time"
        case inCity = "in_city"
        case outCity = "out_city"
    }
}

struct TripTrack: Encodable {
    let heading: Double
    let lat: Double
    let lng: Double
    let speed: Double
    let status: String?
}

struct TripZone: Encodable {
    let distance: Double
    let duration: String
    let kmPrice: Int
    let timePrice: Int
    let waitPrice: Int
    let waitTime: String
}


