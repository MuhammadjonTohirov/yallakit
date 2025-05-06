//
//  DriverCardVerificationGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import NetworkLayer
import Foundation
import Core

protocol DriverCardVerificationProtocol {
    func sendCode(key: String, confirm_code: String) async throws -> DNetCardVerificationResponse?
}

struct DriverCardVerificationGateway: DriverCardVerificationProtocol {
    func sendCode(key number: String, confirm_code: String) async throws -> DNetCardVerificationResponse? {
        
        let request = Request(key: number, confirm_code: confirm_code)
        let response: NetRes<DNetCardVerificationResponse>? = try await Network.sendThrow(request: request)
       
        return response?.result
    }
    
    struct Request: Encodable, URLRequestProtocol {
        let key: String
        let confirm_code: String
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/card/verify")
        }
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        var method: HTTPMethod { .post }
    }
}
