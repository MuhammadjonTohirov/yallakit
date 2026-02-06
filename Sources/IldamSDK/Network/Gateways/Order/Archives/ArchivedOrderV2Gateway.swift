//
//  ArchivedOrdersGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ArchivedOrderV2Gateway.swift
import Foundation
import NetworkLayer

protocol ArchivedOrderV2GatewayProtocol: Sendable {
    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails?
}

struct ArchivedOrderV2Gateway: ArchivedOrderV2GatewayProtocol {
    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await Network.sendThrow(
            request: Request(id: id)
        )
        return result?.result
    }
}

extension ArchivedOrderV2Gateway {
    struct Request: URLRequestProtocol {
        let id: Int
        var body: Data? = nil
        var method: HTTPMethod = .get
        
        var url: URL {
            .baseAPI.appendingPathComponent("/v2/order/archive/show/\(id)")
        }
    }
}
