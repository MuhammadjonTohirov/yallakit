//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation

public protocol DSendOTPUseCaseProtocol {
    func execute(username: String) async throws -> DriverOTPResponse?
}

public final class DSendOTPUseCase: DSendOTPUseCaseProtocol {
    private let gateway: any DSendOTPGatewayProtocol
    
    init(gateway: DSendOTPGatewayProtocol = DriverSendOTPGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverSendOTPGateway()
    }
    
    public func execute(username: String) async throws -> DriverOTPResponse? {
        guard let result = try await gateway.send(phone: username) else {
            return nil
        }
        
        return DriverOTPResponse(networkResponse: result)
    }
}
