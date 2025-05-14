//
//  OrderCancelGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//


import Foundation
import NetworkLayer
import Core
import SwiftUI

protocol OrderCancelGatewayProtocol {
    func cancelOrder(orderId: Int, reasonId: Int, comment: String) async throws -> DNetOrderCancelResult?
}

struct OrderCancelGateway: OrderCancelGatewayProtocol {
     func cancelOrder(orderId: Int, reasonId: Int, comment: String) async throws -> DNetOrderCancelResult? {
        
        let request = Request(
            orderId: orderId,
            reasonId: reasonId,
            reasonComment: comment)
        
        let response: NetRes<DNetOrderCancelResult>? = try await Network.sendThrow(request: request)
       
        return response?.result
    }

    struct Request: Encodable, URLRequestProtocol {
        let orderId: Int
        let reasonId: Int
        let reasonComment: String

        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/order-cancel/\(orderId)")
        }

        var body: Data? {
            self.asData
        }

        var method: HTTPMethod { .put }

        enum CodingKeys: String, CodingKey {
            case reasonId = "reason_id"
            case reasonComment = "reason_comment"
        }
    }
}

