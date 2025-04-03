//
//  LogoutUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// LogoutUseCase.swift
import Foundation

public protocol LogoutUseCaseProtocol {
    func execute() async -> Bool
}

public final class LogoutUseCase: LogoutUseCaseProtocol {
    private let gateway: LogoutGatewayProtocol
    
    init(gateway: LogoutGatewayProtocol = LogoutGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = LogoutGateway()
    }
    
    public func execute() async -> Bool {
        return await gateway.logout()
    }
}
