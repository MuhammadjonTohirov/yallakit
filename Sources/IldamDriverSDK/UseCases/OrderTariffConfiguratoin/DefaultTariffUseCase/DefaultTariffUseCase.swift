//
//  DefaultTariffUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol DefaultTariffUseCaseProtocol {
    func fetchDefaultTariff() async throws -> DriverDefaultTariffResponse
}
public final class DefaultTariffUseCase: DefaultTariffUseCaseProtocol {

    private let gateway: DefaultTariffProtocol
    
    init(gateway: DefaultTariffProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DefaultTariffGateway()
    }

    public func fetchDefaultTariff() async throws -> DriverDefaultTariffResponse {
        guard let result = try await gateway.getDefaultTariff() else {
            throw NSError(domain: "No order found", code: -1)
        }
        return DriverDefaultTariffResponse(from: result)
    }
}
