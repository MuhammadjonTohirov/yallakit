//
//  CancelOrderReasonGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/CancelOrderReasonGateway.swift
import Foundation
import NetworkLayer

protocol CancelOrderReasonGatewayProtocol {
    func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool
}

struct CancelOrderReasonGateway: CancelOrderReasonGatewayProtocol {
    func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool {
        let result: NetRes<String>? = try await Network.sendThrow(
            request: OrderNetworkRoute.cancelOrderReason(
                orderId: orderId,
                reasonId: reasonId,
                reasonComment: reasonComment
            )
        )
        return result?.success ?? false
    }
}
