//
//  SendOTPGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import NetworkLayer
import Core

protocol SendOTPGatewayProtocol {
    func sendOTP(username: String) async throws -> NetResSendOTP?
}

struct SendOTPGateway: SendOTPGatewayProtocol {
    func sendOTP(username: String) async throws -> NetResSendOTP? {
        return (try await Network.sendThrow(request: AuthNetworkRoute.sendOTP(req: .init(phone: username))))?.result
    }
}
