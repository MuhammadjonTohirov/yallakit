//
//  DriverLogOutGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import Foundation
import NetworkLayer

protocol DriverLogOutProtocol {
    func logut() async throws -> Bool?
}

struct DriverLogOutGateway: DriverLogOutProtocol {
    func logut() async throws -> Bool? {
        
        let request = Request()
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }
    
    struct Request: Codable, URLRequestProtocol {
        
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/auth/logout")
        }
        
        var body: Data? {
            nil
        }
        
        var method: HTTPMethod {
            .post
        }
        
    }
}
