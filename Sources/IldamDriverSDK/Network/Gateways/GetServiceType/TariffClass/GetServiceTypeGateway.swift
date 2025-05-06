//
//  ServiceTypeGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import NetworkLayer
import Foundation

protocol ServiceTypeGatewayProtocol {
    func getServiceTypes() async throws -> [DNetServiceTypeItem]
}

struct GetServiceTypeGateway: ServiceTypeGatewayProtocol {
    func getServiceTypes() async throws -> [DNetServiceTypeItem] {
        let request = Request()
        let response: NetRes<[DNetServiceTypeItem]>? = try await Network.sendThrow(request: request)
        
        return response?.result ?? []
    }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/executors/class")
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
