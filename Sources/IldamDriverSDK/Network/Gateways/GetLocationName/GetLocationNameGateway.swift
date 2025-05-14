//
//  GetLocationNameGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol GetLocationNameGatewayProtocol {
    func fetchLocationName(lat: Double, lng: Double) async throws -> DNetGetLocationNameResponse?
}

struct GetLocationNameGateway: GetLocationNameGatewayProtocol {
    func fetchLocationName(lat: Double, lng: Double) async throws -> DNetGetLocationNameResponse? {
        let request = Request(lat: lat, lng: lng)
        let response: NetRes<DNetGetLocationNameResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol, Encodable {
        let lat: Double
        let lng: Double
        
        enum CodingKeys: String, CodingKey {
            case lat = "lat"
            case lng = "lng"
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/location-name")
        }

        var body: Data? {
            self.asData
        }

        var method: HTTPMethod { .post}
    }
}
