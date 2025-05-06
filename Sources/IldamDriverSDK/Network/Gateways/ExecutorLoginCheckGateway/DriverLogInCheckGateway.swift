//
//  ExecutorLoginCheckGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import Foundation
import NetworkLayer

protocol ExecutorLoginCheckGatewayProtocol {
    func checkLoginStatus() async throws -> DNetExecutorLoginCheckResponse?
}

struct DriverLogInCheckGateway: ExecutorLoginCheckGatewayProtocol {
    func checkLoginStatus() async throws -> DNetExecutorLoginCheckResponse? {
        let request = Request()
        let response: NetRes<DNetExecutorLoginCheckResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {  
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/get-data")
        }

        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
