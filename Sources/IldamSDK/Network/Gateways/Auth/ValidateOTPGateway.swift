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

protocol ValidateOTPGatewayProtocol {
    func validate(username: String, code: Int) async -> NetResValidate?
}

struct ValidateOTPGateway: ValidateOTPGatewayProtocol {
    func validate(username: String, code: Int) async -> NetResValidate? {
        let data: NetRes<NetResValidate>? = (await Network.send(request: AuthNetworkRoute.validate(req: .init(phone: username, code: code))))
        return data?.result
    }
}
