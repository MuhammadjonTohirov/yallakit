//
//  OrderAppointedGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import Foundation
import NetworkLayer
import Core

protocol GetAppointedOrderGatewayProtocol {
    func getAppointedOrder(orderId: Int) async throws -> DNetResAppointedOrder?
}

struct GetAppointedOrderGateway: GetAppointedOrderGatewayProtocol {
    func getAppointedOrder(orderId: Int) async throws -> DNetResAppointedOrder? {
        let result: NetRes<DNetResAppointedOrder>? = try await Network.sendThrow(request: Request(orderId: orderId))
        return result?.result
    }

    struct Request: Codable, URLRequestProtocol {
        let orderId: Int
        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/order-appoint/\(orderId)")
        }
        
        var body: Data? { nil }
        
        var method: HTTPMethod { .put }
    }
}
