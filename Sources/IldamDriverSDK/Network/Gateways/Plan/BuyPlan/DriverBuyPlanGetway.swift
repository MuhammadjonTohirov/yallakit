//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import NetworkLayer

protocol DriverBuyPlanProtocol {
    func buyPlan(planId: Int) async throws -> DNetPlanRes?
}

struct DriverBuyPlanGateway: DriverBuyPlanProtocol {
     func buyPlan(planId: Int) async throws -> DNetPlanRes? {
         
        let result: NetRes<DNetPlanRes>? = try await Network.sendThrow(request: Request(planId: planId))
         
        return result?.result
    }
    
    struct Request: Codable, URLRequestProtocol {
        let planId: Int

        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/buy-plan")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod {
            .post
        }
        
        enum CodingKeys: String, CodingKey {
            case planId = "plan_id"
        }
    }
}
