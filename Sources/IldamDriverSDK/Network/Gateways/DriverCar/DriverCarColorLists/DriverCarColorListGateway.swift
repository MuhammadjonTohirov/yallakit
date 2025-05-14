//
//  DriverCarColorListGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import NetworkLayer
import Foundation

protocol DriverCarColorListProtocol {
    func fetchColors() async throws -> [DNetCarColorListResponse]?
}

struct DriverCarColorListGateway: DriverCarColorListProtocol {
 
    func fetchColors() async throws -> [DNetCarColorListResponse]? {
        let request = Request()
        let response: NetRes<[DNetCarColorListResponse]>? = try await Network.sendThrow(request: request)
        
        return response?.result
      }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/color/list")
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}

