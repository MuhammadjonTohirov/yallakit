//
//  RegisterGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// RegisterGateway.swift
import Foundation
import NetworkLayer

protocol RegisterGatewayProtocol {
    func register(req: NetReqRegisterProfile) async -> NetRes<NetResRegisterProfile>?
}

struct RegisterGateway: RegisterGatewayProtocol {
    func register(req: NetReqRegisterProfile) async -> NetRes<NetResRegisterProfile>? {
        return await Network.send(request: AuthNetworkRoute.register(req: req))
    }
}
