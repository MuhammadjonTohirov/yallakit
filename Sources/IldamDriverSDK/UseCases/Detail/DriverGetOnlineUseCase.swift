//
//  DriverGetOnlineUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverGetOnlineUseCaseProtocol {
    func execute() async throws -> DriverGetOnlineResponse
}

public final class DriverGetOnlineUseCase: DriverGetOnlineUseCaseProtocol {
    
    private let gateway: DriverGetOnlineProtocol
    
    public init() {
        self.gateway = DriverGetOnlineGateway()
    }
    
    init(gateway: DriverGetOnlineProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> DriverGetOnlineResponse {
        
        guard let result = try? await gateway.isDriverOnline() else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        
        return DriverGetOnlineResponse(network: result)
    }
}
