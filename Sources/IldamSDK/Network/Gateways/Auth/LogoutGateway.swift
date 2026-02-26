//
//  LogoutGatewayu.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// LogoutGateway.swift
import Foundation
import NetworkLayer

protocol LogoutGatewayProtocol: Sendable {
    func logout() async -> Bool
}

struct LogoutGateway: LogoutGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func logout() async -> Bool {
        let res: NetRes<String>? = await client.send(request: AuthNetworkRoute.logout)
        return res?.success ?? false
    }
}
