//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/02/26.
//

import Foundation
import NetworkLayer

protocol GetOrderDetailsV2GatewayProtocol: Sendable {
    func getOrderDetails(orderId: Int) async throws -> NetResOrderDetails?
}

/// /v2/order/:orderId
struct GetOrderDetailsV2Gateway: GetOrderDetailsV2GatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getOrderDetails(orderId id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await client.sendThrow(
            request: Request(orderId: id)
        )
        return result?.result
    }
}

extension GetOrderDetailsV2Gateway {
    struct Request: URLRequestProtocol {
        var body: Data?
        
        var orderId: Int
        
        var url: URL {
            URL.goIldamV2API.appending(path: "/order/\(orderId)")
        }
        
        var method: HTTPMethod = .get
    }
}
