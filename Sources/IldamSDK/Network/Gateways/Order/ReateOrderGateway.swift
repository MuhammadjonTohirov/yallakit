//
//  ReateOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/RateOrderGateway.swift
import Foundation
import NetworkLayer

protocol RateOrderGatewayProtocol {
    func rateOrder(orderId: Int, rate: Int, comment: String) async throws -> Bool
}

struct RateOrderGateway: RateOrderGatewayProtocol {
    func rateOrder(orderId: Int, rate: Int, comment: String) async throws -> Bool {
        let result: NetRes<[String]>? = try await Network.sendThrow(
            request: OrderNetworkRoute.rateOrder(
                orderId: orderId,
                rate: rate,
                comment: comment
            )
        )
        return result?.success ?? false
    }
}
