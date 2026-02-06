//
//  DeleteOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/CancelOrderGateway.swift
import Foundation
import NetworkLayer

protocol DeleteOrderGatewayProtocol: Sendable {
    func delete(id: Int) async throws -> Bool
}

struct DeleteOrderGateway: DeleteOrderGatewayProtocol {
    func delete(id: Int) async throws -> Bool {
        let result: NetRes<String>? = try await Network.sendThrow(
            request: OrderNetworkRoute.cancelOrder(id: id)
        )
        return result?.success ?? false
    }
}

extension DeleteOrderGateway {
    struct Request: URLRequestProtocol {
        let id: Int
        
        var body: Data? { nil }
        
        var method: HTTPMethod = .put
        
        var url: URL {
            .baseAPI.appendingPathComponent("/v2/archive/order/deleted/\(id)")
        }
    }
}
