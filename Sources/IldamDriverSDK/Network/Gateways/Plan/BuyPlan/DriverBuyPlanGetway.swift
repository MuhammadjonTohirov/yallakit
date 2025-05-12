//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import NetworkLayer

protocol DriverBuyPlanProtocol {
    func buyPlan(planId: Int) async throws -> DriverBuyPlanResponse?
}

public struct DriverBuyPlanGateway: DriverBuyPlanProtocol {
    public func buyPlan(planId: Int) async throws -> DriverBuyPlanResponse? {
        let result: NetRes<DriverBuyPlanResponse>? = try await Network.sendThrow(request: Request(planId: planId))
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
