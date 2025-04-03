//
//  FindExecutorsGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Models/ExecutorRequest.swift
import Foundation
import NetworkLayer

protocol FindExecutorsGatewayProtocol {
    func findExecutors(req: NetReqExecutors) async -> NetResExecutors?
}

struct FindExecutorsGateway: FindExecutorsGatewayProtocol {
    func findExecutors(req: NetReqExecutors) async -> NetResExecutors? {
        let result: NetRes<NetResExecutors>? = await Network.send(request: MainNetworkRoute.findExecutors(req: req))
        return result?.result
    }
}
