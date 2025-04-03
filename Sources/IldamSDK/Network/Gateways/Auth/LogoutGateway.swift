//
//  LogoutGatewayu.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// LogoutGateway.swift
import Foundation
import NetworkLayer

protocol LogoutGatewayProtocol {
    func logout() async -> Bool
}

struct LogoutGateway: LogoutGatewayProtocol {
    func logout() async -> Bool {
        let res: NetRes<String>? = await Network.send(request: AuthNetworkRoute.logout)
        return res?.success ?? false
    }
}
