//
//  BrandGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//


import NetworkLayer
import Foundation

protocol DriverOrderBrandGatewayProtocol {
    func fetchBrand() async throws -> [DNetOrderBrandsResponse]?
    
}

struct DriverOrderBrandGateway: DriverOrderBrandGatewayProtocol {
 
    func fetchBrand() async throws -> [DNetOrderBrandsResponse]? {
        let request = Request()
        let response: NetRes<[DNetOrderBrandsResponse]>? = try await Network.sendThrow(request: request)
        
        return response?.result
      }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/brands")
        }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
