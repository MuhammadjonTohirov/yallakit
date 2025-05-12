//
//  DriverGetOnlineGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol DriverSendConditionProtocol {
     func sendCondtion() async throws -> DNetSendConditionResponse?
}

struct DriverSendConditionGateway: DriverSendConditionProtocol {
    func sendCondtion() async throws -> DNetSendConditionResponse? {
         
        let request = Request()
        let response: NetRes<DNetSendConditionResponse>? = try await Network.sendThrow(request: request)
        
        return response?.result
    }
    
    struct Request: Codable ,URLRequestProtocol {
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/condition")
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .post }
    }

    
    
}
