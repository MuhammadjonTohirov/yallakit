//
//  ExecutorServiceOptionsGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//
import NetworkLayer
import Foundation

protocol ExecutorServiceOptionsGatewayProtocol {
    func fetchServiceOptions() async throws -> DNetServiceOptionsResponse?
}

struct GetExecutorTariffOptionGateway: ExecutorServiceOptionsGatewayProtocol {
    func fetchServiceOptions() async throws -> DNetServiceOptionsResponse? {
        let request = Request()
        let response: NetRes<DNetServiceOptionsResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {
        var url: URL { URL.baseAPIPHP.appendingPathComponent("api/tariff-option") }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
