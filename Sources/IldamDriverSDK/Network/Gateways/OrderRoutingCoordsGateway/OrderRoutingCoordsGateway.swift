//
//  OrderRoutingCoordsGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol OrderRoutingCoordsGatewayProtocol {
    func calculateRoute(points: [DNetOrderRoutingPoint]) async throws -> DNetOrderRoutingResponse?
}

struct OrderRoutingCoordsGateway: OrderRoutingCoordsGatewayProtocol {
    func calculateRoute(points: [DNetOrderRoutingPoint]) async throws -> DNetOrderRoutingResponse? {
        let request = Request(routBody: points)
        
        let response: NetRes<DNetOrderRoutingResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {
    
        var routBody: [DNetOrderRoutingPoint]
        
        enum CodingKeys: String, CodingKey {
            case lat = "lat"
            case lng = "lng"
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/routing/coords")
        }

        var body: Data? {
            try? JSONEncoder().encode(routBody)
        }
        
        var method: HTTPMethod { .post }
    }
}
