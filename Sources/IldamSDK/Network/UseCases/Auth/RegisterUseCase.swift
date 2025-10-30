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
    func execute(request: RegistrationRequest) async -> Bool
}

public struct RegisterUseCase: RegisterUseCaseProtocol {
    private let gateway: RegisterGatewayProtocol
    
    init(gateway: RegisterGatewayProtocol = RegisterGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = RegisterGateway()
    }
    
    public func execute(request: RegistrationRequest) async -> Bool {
        let res = await gateway.register(req: request.toNetworkRequest())
        let code = res?.code ?? 0
        
        if let registerResult = res?.result {
            UserSettings.shared.accessToken = registerResult.accessToken
            UserSettings.shared.tokenExpireDate = registerResult.expirationDate
        }
        
        return code < 300 && code >= 200
    }
}
