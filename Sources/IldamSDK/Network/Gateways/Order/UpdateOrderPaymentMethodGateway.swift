//
//  UpdateOrderPaymentMethodGateway.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 09/02/26.
//

import Foundation
import NetworkLayer

protocol UpdateOrderPaymentMethodGatewayProtocol: Sendable {
    
    func update(orderId: Int, cardId: String?, type: String) async throws -> Bool
}

struct UpdateOrderPaymentMethodGateway: UpdateOrderPaymentMethodGatewayProtocol {
    func update(orderId: Int, cardId: String?, type: String) async throws -> Bool {
        let result: NetRes<String>? = try await Network.sendThrow(request: Request(orderId: orderId, cardId: cardId, type: type))
        
        return result?.success == true
    }
}

extension UpdateOrderPaymentMethodGateway {
    struct Request: Encodable, URLRequestProtocol {
        let orderId: Int
        let cardId: String?
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case cardId = "card_id"
            case type = "payment_type"
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod = .put
        
        var url: URL {
            // /v1/order/pay/update/2177185
            return .goIldamAPI.appending(path: "/v1/order/pay/update/\(orderId)")
        }
    }
}
