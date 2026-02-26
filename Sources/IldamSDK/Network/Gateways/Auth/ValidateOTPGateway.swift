//
//  ValidateOTPGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// ValidateOTPGateway.swift
import Foundation
import NetworkLayer
import Core

protocol ValidateOTPGatewayProtocol: Sendable {
    func validate(username: String, code: String) async -> NetResValidate?
}

struct ValidateOTPGateway: ValidateOTPGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func validate(username: String, code: String) async -> NetResValidate? {
        let data: NetRes<NetResValidate>? = (await client.send(request: AuthNetworkRoute.validate(req: .init(phone: username, code: code))))
        return data?.result
    }
}
