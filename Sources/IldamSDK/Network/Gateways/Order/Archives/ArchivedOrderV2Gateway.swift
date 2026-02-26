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
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await client.sendThrow(
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
            .goIldamV2API.appending(path: "/order/archive/show/\(id)")
        }
    }
}
