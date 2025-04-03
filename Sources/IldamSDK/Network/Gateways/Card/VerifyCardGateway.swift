//
//  VerifyCardGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/VerifyCardGateway.swift
import Foundation
import NetworkLayer

protocol VerifyCardGatewayProtocol {
    func verifyCard(key: String, code: String) async throws -> Bool?
}

struct VerifyCardGateway: VerifyCardGatewayProtocol {
    func verifyCard(key: String, code: String) async throws -> Bool? {
        let result: NetRes<String>? = try await Network.sendThrow(
            request: CardNetworkRouter.validateCard(key: key, code: code)
        )
        return result?.success
    }
}
