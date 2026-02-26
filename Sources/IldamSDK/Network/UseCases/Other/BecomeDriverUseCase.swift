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

public struct BecomeDriverUseCase: BecomeDriverUseCaseProtocol, Sendable {
    private let gateway: BecomeDriverGatewayProtocol

    public init() {
        self.gateway = BecomeDriverGateway()
    }

    init(gateway: BecomeDriverGatewayProtocol) {
        self.gateway = gateway
    }

    public func execute(request: BecomeDriverRequest) async throws -> Bool {
        try await gateway.execute(req: request.toNetworkRequest())
    }
}
