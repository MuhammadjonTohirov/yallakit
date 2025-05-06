//
//  DriverTransportListGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//


import NetworkLayer
import Foundation

protocol DriverTransportListProtocol {
    func fetchCarList() async throws -> [DNetCarListResponse]?
}

struct DriverTransportListGateway: DriverTransportListProtocol {
 
    func fetchCarList() async throws -> [DNetCarListResponse]? {
        let request = Request()
        let response: NetRes<[DNetCarListResponse]>? = try await Network.sendThrow(request: request)
        
        return response?.result 
      }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/transport")
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}

