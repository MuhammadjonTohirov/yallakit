//
//  CancelOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/CancelOrderGateway.swift
import Foundation
import NetworkLayer

protocol CancelOrderGatewayProtocol {
    func cancelOrder(id: Int) async throws -> Bool
}

struct CancelOrderGateway: CancelOrderGatewayProtocol {
    func cancelOrder(id: Int) async throws -> Bool {
        let result: NetRes<String>? = try await Network.sendThrow(
            request: OrderNetworkRoute.cancelOrder(id: id)
        )
        return result?.success ?? false
    }
}
