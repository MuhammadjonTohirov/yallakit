//
//  OrderStatusUpdateGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI
import Core
import NetworkLayer

protocol OrderStatusUpdateGetwayProtocol {
    func orderUpdate(orderId: Int) async throws -> DNetOrderStatusUpdateResponse?
}
struct OrderStatusUpdateGetway: OrderStatusUpdateGetwayProtocol {
    func orderUpdate(orderId: Int
    ) async throws -> DNetOrderStatusUpdateResponse? {
      
        let request = Request(
            orderId: orderId,
            status: "in_fetters", reason_comment: "")
        
        let result: NetRes<DNetOrderStatusUpdateResponse>? = try await Network.sendThrow(request: request)
        return result?.result
    }

    struct Request: Encodable, URLRequestProtocol {
        let orderId: Int // faqat URL uchun
        let status: String
        let reason_comment: String

        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/order/status/update/\(orderId)")
        }

        var body: Data? {
            self.asData // siz yozgan Encodable extension ishlatilmoqda
        }

        var method: HTTPMethod { .put }

        enum CodingKeys: String, CodingKey {
            case status
            case reason_comment
        }
    }
}
