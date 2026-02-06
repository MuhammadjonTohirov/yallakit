//
//  ArchivedOrdersGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/OrderHistoryGateway.swift
import Foundation
import NetworkLayer

protocol ArchivedOrdersV2GatewayProtocol: Sendable {
    func loadHistory(page: Int, limit: Int, brandServiceId: Int?) async -> NetResOrderHistory?
}

struct ArchivedOrdersV2Gateway: ArchivedOrdersV2GatewayProtocol {
    func loadHistory(page: Int, limit: Int = 8, brandServiceId: Int? = nil) async -> NetResOrderHistory? {
        let result: NetRes<NetResOrderHistory>? = await Network.send(
            request: Request(page: page, limit: limit, brandServiceId: brandServiceId)
        )
        return result?.result
    }
}

extension ArchivedOrdersV2Gateway {
    struct Request: URLRequestProtocol {
        let page: Int
        let limit: Int
        let brandServiceId: Int?
        
        var body: Data? = nil
        var method: HTTPMethod = .get
        
        var url: URL {
            var url = URL.baseAPI.appendingPathComponent("/v2/archive/orders")
                .appending(queryItems: [
                    .init(name: "per_page", value: "\(limit)"),
                    .init(name: "page", value: "\(page)"),
                ])
            
            if let brandServiceId = brandServiceId {
                url.append(queryItems: [.init(name: "brand_service_id", value: "\(brandServiceId)")])
            }
            
            return url
        }
    }
}
