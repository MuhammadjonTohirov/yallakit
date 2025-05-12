//
//  ExecutroCardListUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol ExecutorCardListUseCaseProtocol {
    func execute() async throws -> [DriverCardListItem]
}

public final class ExecutorCardListUseCase: ExecutorCardListUseCaseProtocol {
    private let gateway: DriverCardListGatewayProtocol

    init(gateway: DriverCardListGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverCardListGateway()
    }

    public func execute() async throws -> [DriverCardListItem] {
        guard let networkCards = try await gateway.fetchCardList() else {
            return []
        }
        return networkCards.map { DriverCardListItem(from: $0) }
    }
}
