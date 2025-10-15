//
//  CreateFlight.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 13/10/25.
//

import SwiftUI

struct CreateFlightRequest: Codable {
    let brandID, flightID, addressID, tariffID: Int?
    let timeType: String?
    let scheduleID, brandServiceID: Int?
    let date, comment: String?
    let tripSeatLayouts: [TripSeatLayout]?

    enum CodingKeys: String, CodingKey {
        case brandID = "brand_id"
        case flightID = "flight_id"
        case addressID = "address_id"
        case tariffID = "tariff_id"
        case timeType = "time_type"
        case scheduleID = "schedule_id"
        case brandServiceID = "brand_service_id"
        case date, comment
        case tripSeatLayouts = "trip_seat_layouts"
    }
}

// MARK: - TripSeatLayout
struct TripSeatLayout: Codable {
    let seatLayoutID, index: Int?
    let gender: String?
    let isBusy: Bool?
    let isBusyStatus: Int?

    enum CodingKeys: String, CodingKey {
        case seatLayoutID = "seat_layout_id"
        case index, gender
        case isBusy = "is_busy"
        case isBusyStatus = "is_busy_status"
    }
}
