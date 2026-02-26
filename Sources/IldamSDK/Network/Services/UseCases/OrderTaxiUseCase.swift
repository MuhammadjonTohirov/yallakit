//
//  OrderTaxiUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 31/12/24.
//

import Foundation
import NetworkLayer
import Core

public protocol OrderTaxiUseCaseProtocol: Sendable {
    func orderTaxi(req: OrderTaxiRequest) async throws -> Int?
}

public struct OrderTaxiUseCase: OrderTaxiUseCaseProtocol, Sendable {
    public static let shared: OrderTaxiUseCaseProtocol = OrderTaxiUseCase()

    private let client: NetworkClientProtocol

    public init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    public func orderTaxi(req: OrderTaxiRequest) async throws -> Int? {
        Logging.l(tag: "OrderTaxiUseCase", "order taxi")

        let result: NetRes<NetResOrderTaxi>? = try await client.sendThrow(request: MainNetworkRoute.orderTaxi(
            req: .init(model: req)
        ))
        
        return result?.result?.id
    }
}
