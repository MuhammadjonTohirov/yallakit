//
//  LogoutUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// LogoutUseCase.swift
import Foundation

public protocol LogoutUseCaseProtocol: Sendable {
    func execute() async -> Bool
}

public struct LogoutUseCase: LogoutUseCaseProtocol, Sendable {
    private let gateway: LogoutGatewayProtocol

    public init() {
        self.gateway = LogoutGateway()
    }

    init(gateway: LogoutGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async -> Bool {
        return await gateway.logout()
    }
}
