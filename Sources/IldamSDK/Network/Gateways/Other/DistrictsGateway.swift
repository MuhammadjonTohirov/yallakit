//
//  File.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation
import NetworkLayer

protocol DistrictsGatewayProtocol: Sendable {
    func execute() async throws -> [NetResDistrictItem]
}

struct DistrictsGateway: DistrictsGatewayProtocol {
    func execute() async throws -> [NetResDistrictItem] {
        let result: NetRes<[NetResDistrictItem]>? = try await Network.sendThrow(
            request: NetReqDistricts()
        )
        
        return result?.result ?? []
    }
}

extension DistrictsGateway {
    struct NetReqDistricts: URLRequestProtocol {
        var url: URL {
            .goIldamAPI.appendingPath("list", "addresses")
        }
        
        var body: Data? = nil
        
        var method: HTTPMethod = .get
    }
}
