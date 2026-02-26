//
//  FindExecutorsGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// Models/ExecutorRequest.swift
import Foundation
import NetworkLayer

protocol FindExecutorsGatewayProtocol: Sendable {
    func findExecutors(req: NetReqExecutors) async -> NetResExecutors?
}

struct FindExecutorsGateway: FindExecutorsGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func findExecutors(req: NetReqExecutors) async -> NetResExecutors? {
        let result: NetRes<NetResExecutors>? = await client.send(request: MainNetworkRoute.findExecutors(req: req))
        return result?.result
    }
}
