//
//  ActiveBonusegateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 29/10/25.
//

import Foundation
import NetworkLayer

protocol ActivateBonusGatewayProtocol: Sendable {
    func activate(promoCode: String) async throws -> ActivateBonusGateway.Response?
}

@available(*, deprecated, renamed: "ActivateBonusGatewayProtocol")
typealias ActivateBonuseGatewayProtocol = ActivateBonusGatewayProtocol

struct ActivateBonusGateway: ActivateBonusGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func activate(promoCode: String) async throws -> ActivateBonusGateway.Response? {
        let result: NetRes<ActivateBonusGateway.Response>? = try await client.sendThrow(
            request: ActivateBonusGateway.Request(code: promoCode)
        )

        return result?.result
    }
}

@available(*, deprecated, renamed: "ActivateBonusGateway")
typealias ActivateBonuseGateway = ActivateBonusGateway

extension ActivateBonusGateway {
    struct Response: NetResBody {
        var amount: Float?
        var message: String?
    }

    struct Request: URLRequestProtocol, Codable {
        var code: String

        var url: URL {
            URL.baseAPICli
                .appendingPath("client", "activate-promocode")
        }

        var body: Data? {
            self.asData
        }

        var method: NetworkLayer.HTTPMethod = .post

        enum CodingKeys: String, CodingKey {
            case code = "value"
        }
    }
}
