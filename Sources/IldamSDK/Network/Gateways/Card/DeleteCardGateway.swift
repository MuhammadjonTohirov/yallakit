//
//  File.swift
//  YallaKit
//
//  Created by applebro on 30/07/25.
//

import Foundation
import NetworkLayer

protocol DeleteCardGatewayProtocol: Sendable {
    func delete(id: String) async throws -> Bool?
}

struct DeleteCardGateway: DeleteCardGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func delete(id: String) async throws -> Bool? {
        let result: NetRes<DeleteCardGateway.Result>? = try await client.sendThrow(
            request: Request(cardId: id)
        )

        return result?.success
    }
}

extension DeleteCardGateway {
    struct Request: URLRequestProtocol {
        var cardId: String
        
        var url: URL {
            URL.goIldamAPI.appendingPath("card", "deleted", cardId)
        }
        
        var body: Data?
        
        var method: NetworkLayer.HTTPMethod = .put
    }
    
    struct Result: NetResBody {
        
    }
}
