//
//  ExecutorOrderHistoryGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation
import NetworkLayer

protocol ExecutorOrderHistoryGatewayProtocol {
    func fetchOrderHistory(perPage: Int,
                           date: String,
                           type: String,
                           page: Int
    ) async throws -> DNetExecutorOrderHistoryResponse
}

struct ExecutorOrderHistoryGateway: ExecutorOrderHistoryGatewayProtocol {
    func fetchOrderHistory(perPage: Int, date: String, type: String, page: Int) async throws -> DNetExecutorOrderHistoryResponse {
        let request = Request(perPage: perPage, page: page, date: date, type: type)
        let response: NetRes<DNetExecutorOrderHistoryResponse>? = try await Network.send(request: request)
        
        guard let data = response?.result else {
            throw NSError(domain: "No data", code: -1)
        }
        
        return data
    }
    
    
    
    struct Request:Codable, URLRequestProtocol {
        let perPage: Int
        let page: Int
        let date: String
        let type: String
        
        var url: URL {
            URL.baseAPIPHP
                .appending(path: "api")
                .appending(path: "chart/list")
                .appending(queryItems: [
                    .init(name: "per_page", value: "\(perPage)"),
                    .init(name: "date", value: date),
                    .init(name: "f", value: type),
                    .init(name: "page", value: "\(date)")
                ])
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}

