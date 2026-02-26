//
//  GetOrderDetailsGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/GetOrderDetailsGateway.swift
import Foundation
import NetworkLayer

protocol GetOrderDetailsGatewayProtocol: Sendable {
    func getOrderDetails(orderId: Int) async throws -> NetResOrderDetails?
}

struct GetOrderDetailsGateway: GetOrderDetailsGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getOrderDetails(orderId id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await client.sendThrow(
            request: OrderNetworkRoute.order(id: id)
        )
        return result?.result
    }
}
