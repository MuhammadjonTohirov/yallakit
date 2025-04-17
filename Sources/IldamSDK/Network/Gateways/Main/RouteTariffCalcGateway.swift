//
//  RouteAndTariffCalculationGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation
import NetworkLayer
import Core

protocol RouteTariffCalcGatewayProtocol {
    func calculateRouteAndTariffs(
        req: NetReqTaxiTariff
    ) async throws -> (
        map: NetResRouteCoords?,
        tariffs: [NetResTaxiTariff]?
    )
}

final class RouteTariffCalcGateway: RouteTariffCalcGatewayProtocol {
    private lazy var session: URLSession = URLSession(configuration: .default)
    
    func calculateRouteAndTariffs(
        req: NetReqTaxiTariff
    ) async throws -> (map: NetResRouteCoords?, tariffs: [NetResTaxiTariff]?) {
        await session.tasks.0.forEach({$0.cancel()})
        let result: NetRes<NetResRoute>? = try await Network.sendThrow(
            urlSession: session,
            request: MainNetworkRoute.getRouteCoordinates(
                req: req
            )
        )
        
        return (map: result?.result?.map, tariffs: result?.result?.tariff)
    }
}
