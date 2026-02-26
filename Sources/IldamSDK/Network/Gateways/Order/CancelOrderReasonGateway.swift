//
//  CancelOrderReasonGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/CancelOrderReasonGateway.swift
import Foundation
import NetworkLayer

protocol CancelOrderReasonGatewayProtocol: Sendable {
    func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool
}

struct CancelOrderReasonGateway: CancelOrderReasonGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool {
        let result: NetRes<String>? = try await client.sendThrow(
            request: OrderNetworkRoute.cancelOrderReason(
                orderId: orderId,
                reasonId: reasonId,
                reasonComment: reasonComment
            )
        )
        return result?.success ?? false
    }
}
