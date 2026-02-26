//
//  VerifyCardGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/VerifyCardGateway.swift
import Foundation
import NetworkLayer

protocol VerifyCardGatewayProtocol: Sendable {
    func verifyCard(key: String, code: String) async throws -> Bool?
}

struct VerifyCardGateway: VerifyCardGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func verifyCard(key: String, code: String) async throws -> Bool? {
        let result: NetRes<String>? = try await client.sendThrow(
            request: CardNetworkRouter.validateCard(key: key, code: code)
        )
        return result?.success
    }
}
