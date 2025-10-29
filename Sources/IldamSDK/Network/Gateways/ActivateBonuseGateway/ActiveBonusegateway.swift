//
//  ActiveBonusegateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 29/10/25.
//

import Foundation
import NetworkLayer

protocol ActivateBonuseGatewayProtocol {
    func activate(promoCode: String) async throws -> ActivateBonuseGateway.Response?
}

struct ActivateBonuseGateway: ActivateBonuseGatewayProtocol {
    func activate(promoCode: String) async throws -> ActivateBonuseGateway.Response? {
        let result: NetRes<ActivateBonuseGateway.Response>? = try await Network.sendThrow(
            request: ActivateBonuseGateway.Request(code: promoCode)
        )
        
        return result?.result
    }
}

extension ActivateBonuseGateway {
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
