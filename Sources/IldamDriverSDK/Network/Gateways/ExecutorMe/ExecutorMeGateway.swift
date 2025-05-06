//
//  ExecutorMeGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Core
import NetworkLayer
import SwiftUI

protocol ExecutorMeGatewayProtocol {
    func getExecutorMe() async throws -> DNetExecutorMeResponse?
}

struct ExecutorMeGateway: ExecutorMeGatewayProtocol {
    func getExecutorMe() async throws -> DNetExecutorMeResponse? {
        let request = Request()
        let response: NetRes<DNetExecutorMeResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/me")
        }

        var body: Data? { nil }

        var method: HTTPMethod { .post }
    }
}
