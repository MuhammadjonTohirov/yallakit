//
//  DCheckOTPGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import NetworkLayer

protocol DCheckOTPGatewayProtocol {
    func send(code: String) async throws -> DNetResValidate?
}

struct DCheckOTPGateway: DCheckOTPGatewayProtocol {
    func send(code: String) async throws -> DNetResValidate? {
        let request = Request(code: code)
        let res: NetRes<DNetResValidate>? = try await
        Network.sendThrow(request: request)
        
        return res?.result
    }
    struct Request: Codable, URLRequestProtocol {
        let code: String
        
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/auth/login")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod {
            .post
        }
        
        enum CodingKeys: CodingKey {
            case code
        }
    }
    
}
extension URLRequestProtocol {
    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}



