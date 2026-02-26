//
//  ChangeAvatarGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// AvatarResponse.swift
import Foundation

public struct AvatarResponse {
    public let path: String
    public let image: String
    public let fullUrl: String
    
    init(networkResponse: NetResChangeAvatar) {
        self.path = networkResponse.path
        self.image = networkResponse.image
        self.fullUrl = networkResponse.fullUrl
    }
}

// ChangeAvatarGateway.swift
import Foundation
import NetworkLayer
import Core

protocol ChangeAvatarGatewayProtocol: Sendable {
    func changeAvatar(profileAvatar: Data) async throws -> NetRes<NetResChangeAvatar>?
}

struct ChangeAvatarGateway: ChangeAvatarGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func changeAvatar(profileAvatar: Data) async throws -> NetRes<NetResChangeAvatar>? {
        let form = MultipartForm(
            parts: [
                .init(name: "photo", data: profileAvatar, filename: "\(UUID().uuidString).jpg", contentType: "application/octet-stream")
            ],
            boundary: "Boundary-123"
        )

        return try await client.upload(
            body: NetResChangeAvatar.self,
            request: AuthNetworkRoute.changeAvatar(form: form)
        )
    }
}
