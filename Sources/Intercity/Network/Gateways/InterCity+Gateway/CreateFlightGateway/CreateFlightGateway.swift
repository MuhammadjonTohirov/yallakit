//
//  CreateFlightGateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 13/10/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol CreateFlightGatewayProtocol {
    func createFlight(flight: CreateFlightRequest) async -> Bool
}

struct CreateFlightGateway: CreateFlightGatewayProtocol {
    func createFlight(flight: CreateFlightRequest) async -> Bool {
        let request = Self.Request(flight: flight)
        let result: NetRes<Bool>? = await Network.send(request: request)
        return result?.result ?? false
    }
    
    struct Request: Codable, URLRequestProtocol {
        
        let flight: CreateFlightRequest
        
        var body: Data? {
            self.asData
        }
        var url: URL {
            URL.baseAPI.appendingPathComponent("/executor/intercity/trip")
        }
        
        var method: HTTPMethod { .post }

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
}
