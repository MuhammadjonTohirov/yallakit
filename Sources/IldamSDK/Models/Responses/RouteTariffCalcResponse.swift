//
//  RouteAndTariffCalculationResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation
import Core

public struct RouteTariffCalcResponse {
    public var map: RouteData?
    public let tariffs: [TaxiTariff]
    
    public init(map: RouteData?, tariffs: [TaxiTariff]) {
        self.tariffs = tariffs
        self.map = map
    }
}

extension RouteData {
    init?(res: NetResRouteCoords?) {
        guard let res = res else { return nil }
        
        self.init(
            routings: res.routings.map{.init(lat: $0.latitude, lng: $0.longitude, lineType: .carLine)},
            distance: res.distance,
            duration: res.duration
        )
    }
}
