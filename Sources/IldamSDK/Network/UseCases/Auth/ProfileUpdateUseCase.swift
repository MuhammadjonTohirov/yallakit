//
//  ProfileUpdateUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// UpdateProfileUseCase.swift
import Foundation

public protocol UpdateProfileUseCaseProtocol {
    func execute(request: ProfileUpdateRequest) async -> Bool
}

public final class UpdateProfileUseCase: UpdateProfileUseCaseProtocol {
    private let gateway: UpdateProfileGatewayProtocol
    
    init(gateway: UpdateProfileGatewayProtocol = UpdateProfileGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateProfileGateway()
    }
    
    public func execute(request: ProfileUpdateRequest) async -> Bool {
        return await gateway.updateProfile(req: request.toNetworkRequest())
    }
}
