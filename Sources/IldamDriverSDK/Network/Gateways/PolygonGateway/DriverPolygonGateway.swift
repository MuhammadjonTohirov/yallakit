//
//  DriverPolygonGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import Core
import NetworkLayer

protocol DriverPolygonGatewayProtocol {
    func fetchPolygon(by id: Int) async throws -> DNetPolygonResponse?
}

struct DriverPolygonGateway: DriverPolygonGatewayProtocol {
    func fetchPolygon(by id: Int) async throws -> DNetPolygonResponse? {
        let response: NetRes<DNetPolygonResponse>? = try await Network.sendThrow(request: Request(id: id))
        return response?.result
    }

    struct Request: URLRequestProtocol, Codable {
        let id: Int

        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/tariff/polygon/\(id)")
        }

        var body: Data? { nil }

        var method: HTTPMethod { .get }
    }
}
