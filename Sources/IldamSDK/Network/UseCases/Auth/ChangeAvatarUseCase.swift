//
//  ChangeAvatarUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//


// ChangeAvatarUseCase.swift
import Foundation

public protocol ChangeAvatarUseCaseProtocol {
    func execute(profileAvatar: Data) async -> (success: Bool, result: AvatarResponse?)
}

public final class ChangeAvatarUseCase: ChangeAvatarUseCaseProtocol {
    private let gateway: ChangeAvatarGatewayProtocol
    
    init(gateway: ChangeAvatarGatewayProtocol = ChangeAvatarGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ChangeAvatarGateway()
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
