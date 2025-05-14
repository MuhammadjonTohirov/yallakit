//
//  DriverStatisticsGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation
import NetworkLayer

protocol DriverStatisticsGatewayProtocol {
    func fetchStatistics(type: String) async throws -> DNetStatisticsResponse?
}

struct DriverStatisticsGateway: DriverStatisticsGatewayProtocol {
    func fetchStatistics(type: String) async throws -> DNetStatisticsResponse? {
        let request = Request(type: type)
        let response: NetRes<DNetStatisticsResponse>? = try await Network.send(request: request)
        
      
        return response?.result
    }

    struct Request: URLRequestProtocol {
        let type: String
        
        var url: URL {
            URL.baseAPIPHP
                .appending(path: "api")
                .appending(path: "chart")
                .appending(queryItems: [
                    .init(name: "f", value: type)
                ])
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
