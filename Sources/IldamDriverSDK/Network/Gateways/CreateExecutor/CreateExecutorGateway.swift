//
//  CreateExecutorGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol DriverRegisterGatewayProtocol {
    func register(body: DNetDriverRegisterBody) async throws -> DNetDriverRegisterResponse?
}

struct CreateExecutorGateway: DriverRegisterGatewayProtocol {
    func register(body: DNetDriverRegisterBody) async throws -> DNetDriverRegisterResponse? {
        
        let request = Request(item_body: body)
        let response: NetRes<DNetDriverRegisterResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {
        var item_body: DNetDriverRegisterBody?
        var body: Data? {
            self.item_body?.asData
        }
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("/api/register/executor")
        }
        
        var bodyData: Data? {
            try? JSONEncoder().encode(body)
        }
        
        var method: HTTPMethod { .post }
    }
}
