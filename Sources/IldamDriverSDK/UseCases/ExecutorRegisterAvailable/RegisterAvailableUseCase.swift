//
//  RegisterAvailableUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
// ExecutorLoginAvailable

import Foundation

public protocol RegisterAvailableUseCaseProtocol {
    func registerAvailable() async throws -> ExecutorLoginAvailable
}

public final class RegisterAvailableUseCase {
    
    private var gateway: ExecutorLoginCheckGatewayProtocol
    
    init (gateway: ExecutorLoginCheckGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = RegisterAvailableExecutorGateway()
    }
    
    public func registerAvailable() async throws -> ExecutorLoginAvailable {
        guard let result = try await gateway.checkLoginStatus() else {
            throw NSError(domain: "Executor register Available failed", code: -1)
        }
        return ExecutorLoginAvailable(from: result)
    }
}

