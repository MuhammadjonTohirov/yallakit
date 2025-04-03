//
//  ArchivedOrdersGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/ArchivedOrderGateway.swift
import Foundation
import NetworkLayer

protocol ArchivedOrderGatewayProtocol {
    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails?
}

struct ArchivedOrderGateway: ArchivedOrderGatewayProtocol {
    func getArchivedOrder(id: Int) async throws -> NetResOrderDetails? {
        let result: NetRes<NetResOrderDetails>? = try await Network.sendThrow(
            request: OrderNetworkRoute.archivedOrder(id: id)
        )
        return result?.result
    }
}
