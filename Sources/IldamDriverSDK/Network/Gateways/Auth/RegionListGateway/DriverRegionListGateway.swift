//
//  RegionListGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation
import NetworkLayer

protocol RegionListGatewayProtocol {
    func fetchRegions() async throws -> [DNetRegionItem]
}

struct RegionListGateway: RegionListGatewayProtocol {
    func fetchRegions() async throws -> [DNetRegionItem] {
        
        guard let result: NetRes<[DNetRegionItem]> = try await Network.sendThrow(request: Request()) else {
            throw NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response from server"])
        }
        
        guard let regions = result.result else {
            throw NSError(domain: "ParsingError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No region list found in response"])
        }
        
        return regions
    }
    struct Request: URLRequestProtocol {
        var url: URL { URL.baseAPIPHP.appendingPathComponent("region/services") }
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
