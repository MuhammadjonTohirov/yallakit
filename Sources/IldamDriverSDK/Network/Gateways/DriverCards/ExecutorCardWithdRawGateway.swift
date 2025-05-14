//
//  ExecutorCardWithdrawGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation
import NetworkLayer
public protocol ExecutorCardWithdrawGatewayProtocol {
    func withdrawToCard(body: ExecutorCardWithdrawRequest) async throws -> Bool
}

public struct ExecutorCardWithdrawGateway: ExecutorCardWithdrawGatewayProtocol {
    public func withdrawToCard(body: ExecutorCardWithdrawRequest) async throws -> Bool {
        let request = Request(bodyDetail: body)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }

    struct Request: URLRequestProtocol {
        let bodyDetail: ExecutorCardWithdrawRequest
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/card/a2c")
        }

        var body: Data? {
            try? JSONEncoder().encode(bodyDetail)
        }

        var method: HTTPMethod { .post }
    }
}
