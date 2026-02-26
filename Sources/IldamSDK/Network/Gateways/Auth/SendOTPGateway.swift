//
//  SendOTPGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import NetworkLayer
import Core

protocol SendOTPGatewayProtocol: Sendable {
    func sendOTP(username: String) async throws -> NetResSendOTP?
}

struct SendOTPGateway: SendOTPGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func sendOTP(username: String) async throws -> NetResSendOTP? {
        return (try await client.sendThrow(request: AuthNetworkRoute.sendOTP(req: .init(phone: username))))?.result
    }
}
