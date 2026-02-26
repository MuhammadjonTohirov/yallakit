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

public struct DistrictsUseCase: DistrictsUseCaseProtocol, Sendable {
    private let gateway: DistrictsGatewayProtocol

    public init() {
        self.gateway = DistrictsGateway()
    }

    init(gateway: DistrictsGatewayProtocol) {
        self.gateway = gateway
    }

    public func execute() async throws -> [DistrictItem] {
        let result = try await gateway.execute()
        return result.map(DistrictItem.init(networkResponse:))
    }
}
