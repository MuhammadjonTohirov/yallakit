//
//  GetConditionGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol GetConditionGatewayProtocol {
    func getCondition() async throws -> DNetGetConditionResponse?
}

struct DriverGetConditionGateway: GetConditionGatewayProtocol {
    func getCondition() async throws -> DNetGetConditionResponse? {
        
        let request = Request()
        let response: NetRes<DNetGetConditionResponse>? = try await Network.sendThrow(request: request)
        
        return response?.result
    }
    
    struct Request: Codable ,URLRequestProtocol {
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/get-condition")
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
