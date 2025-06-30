//
//  DriverInfoUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public protocol DriverInfoUseCaseProtocol {
    func execute() async throws -> ExecutorLoginResponse?
}

public final class DriverInfoUseCase: DriverInfoUseCaseProtocol {
    private let gateway: AuthMeExecutorProtocol

    init(gateway: AuthMeExecutorProtocol = AuthMeExecutorGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = AuthMeExecutorGateway()
    }

    public func execute() async throws -> ExecutorLoginResponse? {
        guard let result = try await gateway.getAuthMe() else {
            return nil
        }
        return ExecutorLoginResponse(from: result)
    }
}
