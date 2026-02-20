//
//  BecomeDriverUseCase.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation

public protocol BecomeDriverUseCaseProtocol: Sendable {
    func execute(request: BecomeDriverRequest) async throws -> Bool
}

public struct BecomeDriverUseCase: BecomeDriverUseCaseProtocol {
    private let gateway: BecomeDriverGatewayProtocol

    init(gateway: BecomeDriverGatewayProtocol = BecomeDriverGateway()) {
        self.gateway = gateway
    }

    public init() {
        self.gateway = BecomeDriverGateway()
    }

    public func execute(request: BecomeDriverRequest) async throws -> Bool {
        try await gateway.execute(req: request.toNetworkRequest())
    }
}
