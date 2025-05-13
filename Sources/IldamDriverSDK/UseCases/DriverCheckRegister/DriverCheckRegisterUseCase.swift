//
//  DriverCheckRegisterUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
// DriverCheckRegisterUseCaseProtocol

import Foundation

public protocol DriverCheckRegisterUseCaseProtocol {
    func execute() async throws -> ExecutorLoginCheckResponse
}

public final class DriverCheckRegisterUseCase: DriverCheckRegisterUseCaseProtocol {
    private let gateway: ExecutorLoginCheckGatewayProtocol
    
    init(gateway: ExecutorLoginCheckGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverLogInCheckGateway()
    }
    
    public func execute() async throws -> ExecutorLoginCheckResponse {
        guard let result = try await gateway.checkLoginStatus() else {
            throw NSError(domain: "No Executor register found", code: -1)
        }
        
        return ExecutorLoginCheckResponse(from: result)
    }
}
