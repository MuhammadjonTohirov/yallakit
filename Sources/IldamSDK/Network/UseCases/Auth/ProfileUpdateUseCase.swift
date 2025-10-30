//
//  ProfileUpdateUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// UpdateProfileUseCase.swift
import Foundation

public protocol UpdateProfileUseCaseProtocol: Sendable {
    func execute(request: ProfileUpdateRequest) async throws -> Bool
}

public struct UpdateProfileUseCase: UpdateProfileUseCaseProtocol {
    private let gateway: UpdateProfileGatewayProtocol
    
    init(gateway: UpdateProfileGatewayProtocol = UpdateProfileGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateProfileGateway()
    }
    
    public func execute(request: ProfileUpdateRequest) async throws -> Bool {
        try await gateway.updateProfile(req: request.toNetworkRequest())
    }
}
