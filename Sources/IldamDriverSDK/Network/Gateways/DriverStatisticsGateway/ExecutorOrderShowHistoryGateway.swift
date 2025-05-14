//
//  OrderHistoryShowGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation
import NetworkLayer

protocol OrderHistoryShowGatewayProtocol {
    func fetchOrderHistoryShow(orderId: Int) async throws -> DNetOrderHistoryShowResponse
}

struct ExecutorOrderShowHistoryGateway: OrderHistoryShowGatewayProtocol {
    func fetchOrderHistoryShow(orderId: Int) async throws -> DNetOrderHistoryShowResponse {
        let request = Request(orderId: orderId)
        let response: NetRes<DNetOrderHistoryShowResponse>? = try await Network.send(request: request)
        
        guard let data = response?.result else {
            throw NSError(domain: "No data", code: -1)
        }
        
        return data
    }
    
    struct Request: URLRequestProtocol {
        let orderId: Int
        
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/chart/\(orderId)")
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
