//
//  RegisterGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// RegisterGateway.swift
import Foundation
import NetworkLayer

protocol RegisterGatewayProtocol: Sendable {
    func register(req: NetReqRegisterProfile) async throws -> NetRes<NetResRegisterProfile>?
}

struct RegisterGateway: RegisterGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func register(req: NetReqRegisterProfile) async throws -> NetRes<NetResRegisterProfile>? {
        return try await client.sendThrow(request: AuthNetworkRoute.register(req: req))
    }
}
