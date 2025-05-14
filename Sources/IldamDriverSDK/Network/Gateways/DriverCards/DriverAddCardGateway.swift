//
//  asdsa.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import NetworkLayer
import Foundation
import Core

protocol AddCardGatewayProtocol {
    func addCard(number: String, expiry: String) async throws -> DNetDriverAddCardResponse?
}

struct DriverAddCardGateway: AddCardGatewayProtocol {
    func addCard(number: String, expiry: String) async throws -> DNetDriverAddCardResponse? {
        let request = Request(number: number, expiry: expiry)
        let response: NetRes<DNetDriverAddCardResponse>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: Encodable, URLRequestProtocol {
        let number: String
        let expiry: String
    
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/my/card/add")
        }

        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        var method: HTTPMethod { .post }
    }
}
