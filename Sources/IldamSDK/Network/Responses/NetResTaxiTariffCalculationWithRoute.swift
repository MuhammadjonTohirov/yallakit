//
//  NetResRouteCoords.swift
//  Ildam
//
//  Created by applebro on 28/12/23.
//

import Foundation

struct NetResTaxiTariffCalculationWithRoute: NetResBody {
    var map: NetResRouteCoords?
    var tariff: [NetResTaxiTariff]
    var working: NetResTaxiWorking?
}
