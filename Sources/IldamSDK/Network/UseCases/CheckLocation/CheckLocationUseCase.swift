//
//  CheckLocationUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 20/10/25.
//

import SwiftUI
import NetworkLayer
import Core

public protocol CheckLocationUseCaseProtocol {
    func checkLocation(lat: Double, lng: Double) async throws -> CheckLocationResult
}

public struct CheckLocationUseCase: CheckLocationUseCaseProtocol {
        
    private var gateway: any CheckLocationGatewayProtocol = CheckLocationGateway()

    init(gateway: any CheckLocationGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = CheckLocationGateway()
    }
    
    public func checkLocation(lat: Double, lng: Double) async throws -> CheckLocationResult {
         
        let netResult = try await self.gateway.checkLocation(lat: lat, lng: lng)
        guard let result = try CheckLocationResult(from: netResult) else {
            throw NetworkError.custom(message: "No location check founded", code: -1)
        }
        return result
        
    }
    
}

