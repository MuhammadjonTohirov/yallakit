//
//  CheckLocationUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 20/10/25.
//

import SwiftUI
import NetworkLayer
import Core

public protocol CheckLocationUseCaseProtocol: Sendable {
    func checkLocation(lat: Double, lng: Double) async throws -> CheckLocationResult
}

public struct CheckLocationUseCase: CheckLocationUseCaseProtocol, Sendable {
    private let gateway: CheckLocationGatewayProtocol

    public init() {
        self.gateway = CheckLocationGateway()
    }

    init(gateway: CheckLocationGatewayProtocol) {
        self.gateway = gateway
    }

    public func checkLocation(lat: Double, lng: Double) async throws -> CheckLocationResult {
        let netResult = try await self.gateway.checkLocation(lat: lat, lng: lng)
        guard let result = try CheckLocationResult(from: netResult) else {
            throw NetworkError.custom(message: "No location check founded", code: -1)
        }
        return result
    }
}

