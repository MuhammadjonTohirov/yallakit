//
//  Untitled.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import Foundation
import NetworkLayer
import Core

protocol OrderSkipProtocol {
    func skipOrder(
        orderId: Int,
        status: String,
        reasonComment: String) async throws -> DNetOrderSkipResponse?
}

struct OrderSkipGateway: OrderSkipProtocol {
    func skipOrder(
        orderId: Int,
        status: String,
        reasonComment: String) async throws -> DNetOrderSkipResponse? {
          
            let request = Request(
                orderId: orderId,
                status: status,
                reasonComment: reasonComment
            )
            
            let response: NetRes<DNetOrderSkipResponse>? = try await Network.sendThrow(request: request)
            
            return response?.result
        }
    
    struct Request: Codable, URLRequestProtocol {
        var orderId: Int = 0
        let status: String
        let reasonComment: String
        
        enum CodingKeys: String, CodingKey {
            case status
            case reasonComment = "reason_comment"
        }
        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/order-skip/\(orderId)")
        }
        var body: Data? { self.asData }
        
        var method: HTTPMethod { .put }
    }
}
