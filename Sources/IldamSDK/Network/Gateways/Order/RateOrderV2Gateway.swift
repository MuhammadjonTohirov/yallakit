//
//  ReateOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Gateways/RateOrderGateway.swift
import Foundation
import NetworkLayer

protocol RateOrderV2GatewayProtocol {
    func rateOrder(orderId: Int, rate: Int, comment: String, ratingReasonIds: [Int]) async throws -> Bool
}

struct RateOrderV2Gateway: RateOrderV2GatewayProtocol {
    func rateOrder(orderId: Int, rate: Int, comment: String, ratingReasonIds: [Int] = []) async throws -> Bool {
        let result: NetRes<[String]>? = try await Network.sendThrow(
            request: Request(input: .init(ball: rate, orderId: orderId, comment: comment, reasonIds: ratingReasonIds))
        )
        return result?.success ?? false
    }
}

extension RateOrderV2Gateway {
    struct Request: URLRequestProtocol {
        let input: NetReqRateOrder
        
        var url: URL {
            .goIldamAPI.appending(path: "/order/rating/\(input.orderId)")
        }
        
        var body: Data? {
            input.asData
        }
        
        var method: HTTPMethod = .put
    }
}
