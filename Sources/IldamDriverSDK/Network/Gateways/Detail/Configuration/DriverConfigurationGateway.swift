//
//  DriverConfigurationGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation
import NetworkLayer

protocol DriverConfigurationProtocol {
    func fetchConfig() async throws ->  DNetDriverConfigurationResponse?
}
struct DriverConfigurationGateway: DriverConfigurationProtocol {
    func fetchConfig() async throws -> DNetDriverConfigurationResponse? {
         let request = Request()
        let res: NetRes<DNetDriverConfigurationResponse>? = try? await Network.sendThrow(request: request)
        
        return res?.result
    }
    struct Request: Encodable ,URLRequestProtocol {
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("/executor/configuration")
        }
        
        var body: Data? {
            nil
        }
        var method: HTTPMethod { .get }
    }
    
}
