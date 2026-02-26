//
//  RouteAndTariffCalculationGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation
import NetworkLayer
import Core

protocol RouteTariffCalcGatewayProtocol: Sendable {
    func calculateRouteAndTariffs(
        req: NetReqTaxiTariff
    ) async throws -> NetResTaxiTariffCalculationWithRoute?
}

final class RouteTariffCalcGateway: RouteTariffCalcGatewayProtocol, @unchecked Sendable {
    private lazy var session: URLSession = URLSession(configuration: .default)
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func calculateRouteAndTariffs(
        req: NetReqTaxiTariff
    ) async throws -> NetResTaxiTariffCalculationWithRoute? {
        await session.tasks.0.forEach({$0.cancel()})
        let result: NetRes<NetResTaxiTariffCalculationWithRoute>? = try await client.sendThrow(
            urlSession: session,
            request: MainNetworkRoute.getRouteCoordinates(
                req: req
            )
        )

        return result?.result
    }
}
