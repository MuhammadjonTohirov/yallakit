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
    func register(req: NetReqRegisterProfile) async throws -> NetRes<NetResRegisterProfile>? {
        return try await Network.sendThrow(request: AuthNetworkRoute.register(req: req))
    }
}
