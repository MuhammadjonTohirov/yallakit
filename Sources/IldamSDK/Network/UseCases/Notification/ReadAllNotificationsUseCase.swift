//
//  ReadAllNotifsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol ReadAllNotifsUseCaseProtocol: Sendable {
    func execute() async throws -> Bool
}

public struct ReadAllNotifsUseCase: ReadAllNotifsUseCaseProtocol, Sendable {
    private let gateway: ReadAllNotifsGateway

    public init() {
        self.gateway = ReadAllNotifsGatewayImpl()
    }

    init(gateway: ReadAllNotifsGateway) {
        self.gateway = gateway
    }

    public func execute() async throws -> Bool {
        try await gateway.execute()
    }
}
