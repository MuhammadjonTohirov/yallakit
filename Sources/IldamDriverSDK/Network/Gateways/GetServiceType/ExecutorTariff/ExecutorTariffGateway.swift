//
//  ExecutorTariffGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation
import NetworkLayer

protocol ExecutorTariffGatewayProtocol {
    func fetchExecutorTariffs() async throws -> DNetExecutorTariffListResponse
}

struct ExecutorTariffGateway: ExecutorTariffGatewayProtocol {
    func fetchExecutorTariffs() async throws -> DNetExecutorTariffListResponse {
        let request = Request()
        let response: NetRes<DNetExecutorTariffListResponse>? = try await Network.send(request: request)
        
        guard let result = response?.result else {
            throw NetworkError.emptyResponse
        }
        
        return result
    }

    struct Request: URLRequestProtocol {
        var url: URL { URL.baseAPIPHP.appendingPathComponent("api/executor-tariff") }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
