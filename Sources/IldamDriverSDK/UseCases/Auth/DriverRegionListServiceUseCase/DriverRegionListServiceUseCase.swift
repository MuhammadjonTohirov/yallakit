//
//  RegionListUseCaseProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

public protocol RegionListUseCaseProtocol {
    func execute() async throws -> [RegionListItem]
}

public final class RegionListUseCase: RegionListUseCaseProtocol {
    private let gateway: RegionListGatewayProtocol

    init(gateway: RegionListGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = RegionListGateway()
    }


    public func execute() async throws -> [RegionListItem] {
        let networkRegions = try await gateway.fetchRegions()
        return networkRegions.map(RegionListItem.init)
    }
}
