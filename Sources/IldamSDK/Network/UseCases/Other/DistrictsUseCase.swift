//
//  DistrictsUseCase.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation

public protocol DistrictsUseCaseProtocol: Sendable {
    func execute() async throws -> [DistrictItem]
}

public final class DistrictsUseCase: DistrictsUseCaseProtocol {
    private let gateway: DistrictsGatewayProtocol

    init(gateway: DistrictsGatewayProtocol = DistrictsGateway()) {
        self.gateway = gateway
    }

    public init() {
        self.gateway = DistrictsGateway()
    }

    public func execute() async throws -> [DistrictItem] {
        let result = try await gateway.execute()
        return result.map(DistrictItem.init(networkResponse:))
    }
}
