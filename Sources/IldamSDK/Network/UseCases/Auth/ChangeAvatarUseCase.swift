//
//  ChangeAvatarUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//


// ChangeAvatarUseCase.swift
import Foundation

public protocol ChangeAvatarUseCaseProtocol: Sendable {
    func execute(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?)
}

public struct ChangeAvatarUseCase: ChangeAvatarUseCaseProtocol, Sendable {
    private let gateway: ChangeAvatarGatewayProtocol

    public init() {
        self.gateway = ChangeAvatarGateway()
    }

    init(gateway: ChangeAvatarGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?) {
        do {
            let networkResult = try await gateway.changeAvatar(profileAvatar: profileAvatar)
            let result = networkResult?.result.map { AvatarResponse(networkResponse: $0) }
            return (true, result)
        } catch {
            return (false, nil)
        }
    }
}
