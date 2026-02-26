//
//  CancelOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/CancelOrderGateway.swift
import Foundation
import NetworkLayer

protocol CancelOrderGatewayProtocol: Sendable {
    func cancelOrder(id: Int) async throws -> Bool
}

struct CancelOrderGateway: CancelOrderGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func cancelOrder(id: Int) async throws -> Bool {
        let result: NetRes<String>? = try await client.sendThrow(
            request: OrderNetworkRoute.cancelOrder(id: id)
        )
        return result?.success ?? false
    }
}
