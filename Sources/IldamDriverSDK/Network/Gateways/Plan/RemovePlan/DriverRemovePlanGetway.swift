//
//  RemovePlanGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import NetworkLayer

protocol DriverRemovePlanProtocol {
    func removePlan(planId: Int) async throws -> DriverRemovePlanResponse?
}

public struct DriverRemovePlanGetway: DriverRemovePlanProtocol {
    func removePlan(planId: Int) async throws -> DriverRemovePlanResponse? {
        
        let result: NetRes<DriverRemovePlanResponse>? = try? await Network.sendThrow(request: Request(planId: planId))
        
        return result?.result
    }
    struct Request: Codable, URLRequestProtocol {
        let planId: Int

        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/remove-plan/\(planId)")
        }
        
        var body: Data? {
            nil
        }
        
        var method: HTTPMethod {
            .put
        }
         
    }
    
}
