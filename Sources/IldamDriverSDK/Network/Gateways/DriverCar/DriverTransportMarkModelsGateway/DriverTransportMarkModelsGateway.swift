//
//  DriverTransportMarkModelsGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//


import NetworkLayer
import Foundation

protocol DriverTransportMarkModelsProtocol {
    func fetchCarList() async throws -> [DNetTransportMarkModelsResponse]?
}

struct DriverTransportMarkModelsGateway: DriverTransportMarkModelsProtocol {
 
    func fetchCarList() async throws -> [DNetTransportMarkModelsResponse]? {
        let request = Request()
        let response: NetRes<[DNetTransportMarkModelsResponse]>? = try await Network.sendThrow(request: request)
        
        return response?.result 
      }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/transport-mark-models")
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}

