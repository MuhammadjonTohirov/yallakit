//
//  CreateExecutorUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol CreateExecutorUseCaseProtocol {
    func execute(body: DNetDriverRegisterBody) async throws -> CreateExecutorResponse
}

public final class CreateExecutorUseCase: CreateExecutorUseCaseProtocol {
    private let gateway: DriverRegisterGatewayProtocol
    
    public func execute(body: DNetDriverRegisterBody) async throws -> CreateExecutorResponse {
        guard let result = try? await gateway.register(body: body) else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        return CreateExecutorResponse(from: result)
    }
    
    init(gateway: DriverRegisterGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = CreateExecutorGateway()
    }
    
    
    
}
