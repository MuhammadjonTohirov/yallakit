//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import NetworkLayer

protocol DSendOTPGatewayProtocol {
    func send(phone: String) async throws -> DNetResSendOTP?
}

struct DSendOTPGateway: DSendOTPGatewayProtocol {
    func send(phone: String) async throws -> DNetResSendOTP? {
        let res: NetRes<DNetResSendOTP>? = try await Network.sendThrow(request: Request(phone: phone))
        
        return res?.result
    }
    
    struct Request: Codable, URLRequestProtocol {
        let phone: String
        
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/executor")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod {
            .post
        }
        
        enum CodingKeys: CodingKey {
            case phone
        }
    }
}
