//
//  ActiveOrdersGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ActiveOrdersGateway.swift
import Foundation
import NetworkLayer

protocol ActiveOrdersGatewayProtocol: Sendable {
    func getActiveOrders() async throws -> [NetResOrderDetails]?
}

struct ActiveOrdersGateway: ActiveOrdersGatewayProtocol {
    func getActiveOrders() async throws -> [NetResOrderDetails]? {
        let result: NetRes<NetResActiveOrders>? = try await Network.sendThrow(
            request: OrderNetworkRoute.activeOrders
        )
        return result?.result?.list
    }
}
