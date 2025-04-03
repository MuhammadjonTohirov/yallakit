//
//  ActiveOrdersCountGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ActiveOrdersCountGateway.swift
import Foundation
import NetworkLayer

protocol ActiveOrdersCountGatewayProtocol {
    func getActiveOrdersCount() async throws -> Int?
}

struct ActiveOrdersCountGateway: ActiveOrdersCountGatewayProtocol {
    func getActiveOrdersCount() async throws -> Int? {
        let result: NetRes<NetResActiveOrdersCount>? = try await Network.sendThrow(
            request: OrderNetworkRoute.activeOrdersCount
        )
        return result?.result?.count
    }
}
