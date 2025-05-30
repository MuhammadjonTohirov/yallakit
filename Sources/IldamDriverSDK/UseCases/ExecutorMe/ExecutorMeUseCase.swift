//
//  ExecutorMeUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol ExecutorMeUseCaseProtocol {
    func fetchMe() async throws -> ExecutorMeInfo
}

public final class ExecutorMeUseCase: ExecutorMeUseCaseProtocol {
    
    private var gateway: ExecutorMeGatewayProtocol
    
    init(gateway: ExecutorMeGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorMeGateway()
    }
    
    public func fetchMe() async throws -> ExecutorMeInfo {
        guard let res = try await gateway.getExecutorMe() else {
            throw NSError(domain: "Sending fetchMe failed", code: -1)
        }
        
        return ExecutorMeInfo(from: res)
    }
}
