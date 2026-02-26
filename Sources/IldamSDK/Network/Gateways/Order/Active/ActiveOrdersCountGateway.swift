//
//  ActiveOrdersCountGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ActiveOrdersCountGateway.swift
import Foundation
import NetworkLayer

protocol ActiveOrdersCountGatewayProtocol: Sendable {
    func getActiveOrdersCount() async throws -> Int?
}

struct ActiveOrdersCountGateway: ActiveOrdersCountGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getActiveOrdersCount() async throws -> Int? {
        let result: NetRes<NetResActiveOrdersCount>? = try await client.sendThrow(
            request: OrderNetworkRoute.activeOrdersCount
        )
        return result?.result?.count
    }
}
