//
//  ReateOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/RateOrderGateway.swift
import Foundation
import NetworkLayer

protocol RateOrderGatewayProtocol: Sendable {
    func rateOrder(orderId: Int, rate: Int, comment: String, ratingReasonIds: [Int]) async throws -> Bool
}

struct RateOrderGateway: RateOrderGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func rateOrder(orderId: Int, rate: Int, comment: String, ratingReasonIds: [Int] = []) async throws -> Bool {
        let result: NetRes<[String]>? = try await client.sendThrow(
            request: OrderNetworkRoute.rateOrder(
                orderId: orderId,
                rate: rate,
                comment: comment,
                ratingReasonIds: ratingReasonIds
            )
        )
        return result?.success ?? false
    }
}
