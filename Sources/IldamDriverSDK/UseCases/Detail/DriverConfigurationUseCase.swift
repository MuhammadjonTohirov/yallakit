//
//  DriverConfigurationUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverConfigurationUseCaseProtocol {
    func execute() async throws -> DriverConfiguration
}

public final class DefaultDriverConfigurationUseCase: DriverConfigurationUseCaseProtocol {
    private let gateway: DriverConfigurationProtocol

    public func execute() async throws -> DriverConfiguration {
        guard let result = try await gateway.fetchConfig() else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        return DriverConfiguration(from: result)
    }

    init(gateway: DriverConfigurationProtocol = DriverConfigurationGateway() ) {
        self.gateway = gateway
    }
    public init () {
        self.gateway = DriverConfigurationGateway()
    }
}
