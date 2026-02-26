//
//  ArchivedOrdersGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ArchivedOrderGateway.swift
import Foundation
import NetworkLayer

protocol ArchivedOrderGatewayProtocol: Sendable {
    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails?
}

struct ArchivedOrderGateway: ArchivedOrderGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await client.sendThrow(
            request: OrderNetworkRoute.archivedOrder(id: id)
        )
        return result?.result
    }
}
