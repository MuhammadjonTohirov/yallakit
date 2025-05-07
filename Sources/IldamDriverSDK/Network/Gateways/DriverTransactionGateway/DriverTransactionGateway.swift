//
//  DriverTransactionGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//


import Foundation
import NetworkLayer

protocol DriverTransactionGatewayProtocol {
    func fetchTransactions(type: String) async throws -> DNetDriverTransactionResponse
}

struct DriverTransactionGateway: DriverTransactionGatewayProtocol {
    func fetchTransactions(type: String) async throws -> DNetDriverTransactionResponse {
        let request = Request(type: type)
        let response: NetRes<DNetDriverTransactionResponse>? = try await Network.sendThrow(request: request)
        
        guard let data = response?.result else {
            throw NSError(domain: "No data", code: -1)
        }
        
        return data
    }
    
    struct Request: URLRequestProtocol {
        let type: String

        var url: URL {
            URL.baseAPIPHP
                .appending(path: "/api/transactions")
                .appending(queryItems: [
                    .init(name: "f", value: type)
                ])
            
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
