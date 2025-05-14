//
//  AuthGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol AuthMeExecutorProtocol {
    func getAuthMe() async throws -> DNetExecutorLoginResponse?
    
}
struct AuthMeExecutorGateway:AuthMeExecutorProtocol  {
    func getAuthMe() async throws -> DNetExecutorLoginResponse? {
        
        let requst = Request()
        let response: NetRes<DNetExecutorLoginResponse>? = try await Network.sendThrow(request: requst)
        
        return response?.result
    }
    
    struct Request: Codable, URLRequestProtocol {
        
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/auth/me")
        }
        
        var body: Data? {
            nil
        }
        
        var method: HTTPMethod {
            .post
        }
        
    }
    
}
