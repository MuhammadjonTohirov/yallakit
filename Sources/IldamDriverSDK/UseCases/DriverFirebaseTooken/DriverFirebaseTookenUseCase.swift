//
//  DriverFirebaseTookenUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol DriverFirebaseTookenUseCaseProtocol {
    func sendTooken(tooken: String) async throws -> Bool?
}

public final class DriverFirebaseTookenUseCase {
    private var gateway: DriverFirebaseTookenGatewayProtocol
    
    init(gateway: DriverFirebaseTookenGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverFirebaseTookenGateway()
    }
    
    func sendTooken(tooken: String) async throws -> Bool? {
        let result = try await gateway.sendTooken(tooken: tooken)
        
        return true
    }

}
