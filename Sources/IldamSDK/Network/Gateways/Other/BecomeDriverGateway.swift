//
//  File.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation
import NetworkLayer

protocol BecomeDriverGatewayProtocol: Sendable {
    func execute(req: NetReqBeDriver) async throws -> Bool
}

struct BecomeDriverGateway: BecomeDriverGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func execute(req: NetReqBeDriver) async throws -> Bool {
        let result: NetRes<[NetResDistrictItem]>? = try await client.sendThrow(request: req)

        return result?.success == true
    }
}

extension NetReqBeDriver: URLRequestProtocol {
    var url: URL {
        .goIldamAPI.appending(path: "client-to-be-driver")
    }
    
    var method: HTTPMethod { .post }
    
    var body: Data? {
        self.asData
    }
}
