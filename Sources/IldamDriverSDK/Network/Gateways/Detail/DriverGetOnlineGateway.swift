//
//  DriverGetOnlineGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol DriverGetOnlineProtocol {
    func isDriverOnline() async throws -> DNetGetOnlineResponse?
}

struct DriverGetOnlineGateway: DriverGetOnlineProtocol {
    func isDriverOnline() async throws -> DNetGetOnlineResponse? {
         
        let request = Request()
        let response: NetRes<DNetGetOnlineResponse>? = try await Network.sendThrow(request: request)
        
        return response?.result
    }
    
    struct Request: Codable ,URLRequestProtocol {
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/get-online")
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
