//
//  ProfileUpdateGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// UpdateProfileGateway.swift
import Foundation
import NetworkLayer

protocol UpdateProfileGatewayProtocol: Sendable {
    func updateProfile(req: NetReqUpdateProfile) async throws -> Bool
}

struct UpdateProfileGateway: UpdateProfileGatewayProtocol {
    func updateProfile(req: NetReqUpdateProfile) async throws -> Bool {
        let res: NetRes<Bool>? = try await Network.sendThrow(request: AuthNetworkRoute.updateProfile(
            givenNames: req.givenNames,
            surName: req.surName,
            birthday: req.birthday,
            gender: req.gender,
            image: req.image
        ))
        return res?.success ?? false
    }
}

