//
//  DriverFotoControlResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol DriverFotoControlGatewayProtocol {
    func getFotoControlShapes() async throws -> [DNetFotoControlItem]?
}

struct GetDriverFotoControlGateway: DriverFotoControlGatewayProtocol {
    func getFotoControlShapes() async throws -> [DNetFotoControlItem]? {
        let request = Request()
        let response: NetRes<[DNetFotoControlItem]>? = try await Network.sendThrow(request: request)
        return response?.result
    }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/get-files")
        }

        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
