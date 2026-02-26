//
//  RegisterUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// RegisterUseCase.swift
import Foundation
import Core

public protocol RegisterUseCaseProtocol: Sendable {
    func execute(request: RegistrationRequest) async throws -> Bool
}

public struct RegisterUseCase: RegisterUseCaseProtocol, Sendable {
    private let gateway: RegisterGatewayProtocol

    public init() {
        self.gateway = RegisterGateway()
    }

    init(gateway: RegisterGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(request: RegistrationRequest) async throws -> Bool {
        let res = try await gateway.register(req: request.toNetworkRequest())
        let code = res?.code ?? 0
        
        if let registerResult = res?.result {
            UserSettings.shared.accessToken = registerResult.accessToken
            UserSettings.shared.tokenExpireDate = registerResult.expirationDate
        }
        
        return code < 300 && code >= 200
    }
}
