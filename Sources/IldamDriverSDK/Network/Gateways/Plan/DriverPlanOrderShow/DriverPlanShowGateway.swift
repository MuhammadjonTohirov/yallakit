//
//  DriverPlanShow.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import NetworkLayer
import Core

protocol DriverPlanShowProtocol {
    func getPlanShow(planId: Int) async throws -> DriverPlanShowResponse?
}

struct DriverPlanShowGateway: DriverPlanShowProtocol {

    func getPlanShow(planId: Int) async throws -> DriverPlanShowResponse? {
        let response: NetRes<DriverPlanShowResponse>? = try await Network.sendThrow(request: Request(planId: planId))
        return response?.result
    }

    struct Request: Codable, URLRequestProtocol {
        let planId: Int
        
        var url: URL {
            URL.baseAPI
                .appending(path: "executor")
                .appendingPathComponent("plan/\(planId)")
        }
        
        var body: Data? { nil }
        
        var method: HTTPMethod { .get }
    }
}
