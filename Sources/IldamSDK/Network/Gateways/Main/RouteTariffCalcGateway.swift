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

struct RouteTariffCalcGateway: RouteTariffCalcGatewayProtocol {
    func calculateRouteAndTariffs(
        req: NetReqTaxiTariff
    ) async throws -> (map: NetResRouteCoords?, tariffs: [NetResTaxiTariff]?) {

        let result: NetRes<NetResRoute>? = try await Network.sendThrow(
            request: MainNetworkRoute.getRouteCoordinates(
                req: req
            )
        )
        
        return (map: result?.result?.map, tariffs: result?.result?.tariff)
    }
}
