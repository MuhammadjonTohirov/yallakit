//
//  TripCalculationGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//


import Foundation
import NetworkLayer
import Core
import SwiftUI

protocol OrderComplateProtocol {
    func complateOrder(orderId: Int, body: TripCalculationBody) async throws -> DNetOrderComplateResponse?
}

struct OrderComplateGateway: OrderComplateProtocol {
    func complateOrder(orderId: Int, body: TripCalculationBody) async throws -> DNetOrderComplateResponse? {
        
        let request = Request(orderId: orderId, taxiOrder: body.taxiOrder)
        let response: NetRes<DNetOrderComplateResponse>? = try await Network.sendThrow(request: request)
        
        return response?.result
    }
    
    struct Request: Encodable,URLRequestProtocol {
        let orderId: Int
        let taxiOrder: TaxiOrder

        enum CodingKeys: String, CodingKey {
            case taxiOrder = "taxi_order"
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/order-complete/\(orderId)")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod { .put }
    }
}
