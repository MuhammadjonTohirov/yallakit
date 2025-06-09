//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import Core
import NetworkLayer

protocol DriverPlanListProtocol {
    func getPlanLists() async throws -> [DNetPlanListRes]?
}

struct DriverPlanListGatewayGetway: DriverPlanListProtocol {
    func getPlanLists() async throws -> [DNetPlanListRes]? {
        let result: NetRes<[DNetPlanListRes]>? = try await Network.sendThrow(request: Request())
        return result?.result
        
        
        struct Request: Codable, URLRequestProtocol {
            var url: URL {
                URL.baseAPI
                    .appending(path: "executor")
                    .appending(path: "plans")
            } 
            
            var body: Data? {
                nil
            }
            
            var method: HTTPMethod {
                .get
            }
        }
    }
}
