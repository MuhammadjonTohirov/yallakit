//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 06/02/26.
//

import Foundation
import NetworkLayer

protocol ActiveOrdersV2GatewayProtocol {
    func getActiveOrders() async throws -> [NetResOrderDetails]?
}

struct ActiveOrdersV2Gateway: ActiveOrdersGatewayProtocol {
    func getActiveOrders() async throws -> [NetResOrderDetails]? {
        let result: NetRes<NetResActiveOrders>? = try await Network.sendThrow(
            request: Request()
        )
        return result?.result?.list
    }
}

extension ActiveOrdersV2Gateway {
    struct Request: URLRequestProtocol {
        var body: Data?
        
        var url: URL {
            URL.goIldamV2API.appending(path: "/active/orders")
        }
        
        var method: HTTPMethod = .get
    }
}
