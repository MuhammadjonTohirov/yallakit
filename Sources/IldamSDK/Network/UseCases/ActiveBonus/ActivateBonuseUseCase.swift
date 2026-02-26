//
//  ActivateBonuseUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 29/10/25.
//

import Foundation
import SwiftUI

public protocol ActivateBonusUseCaseProtocol: Sendable {
    func activate(promoCode: String) async throws -> ActivatePromocodeResult?
}

@available(*, deprecated, renamed: "ActivateBonusUseCaseProtocol")
public typealias ActivateBonuseUseCaseProtocol = ActivateBonusUseCaseProtocol

public struct ActivateBonusUseCase: ActivateBonusUseCaseProtocol, Sendable {
    private let gateway: ActivateBonusGatewayProtocol

    public init() {
        self.gateway = ActivateBonusGateway()
    }

    init(gateway: ActivateBonusGatewayProtocol) {
        self.gateway = gateway
    }

    public func activate(promoCode: String) async throws -> ActivatePromocodeResult? {
        guard let result = try await gateway.activate(promoCode: promoCode) else {
            return nil
        }

        return .init(value: result.amount, message: result.message)
    }
}

@available(*, deprecated, renamed: "ActivateBonusUseCase")
public typealias ActivateBonuseUseCase = ActivateBonusUseCase
