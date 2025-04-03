//
//  RouteCalculationUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/RouteCalculationUseCase.swift
import Foundation
import Core
import CoreLocation

public protocol RouteTariffCalcUseCaseProtocol {
    func execute(request: RouteTariffCalcRequest) async throws -> RouteTariffCalcResponse?
}

public final class RouteTariffCalcUseCase: RouteTariffCalcUseCaseProtocol {
    private let gateway: RouteTariffCalcGatewayProtocol
    
    init(gateway: RouteTariffCalcGatewayProtocol = RouteTariffCalcGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = RouteTariffCalcGateway()
    }
    
    public func execute(request: RouteTariffCalcRequest) async throws -> RouteTariffCalcResponse? {
        let netPoints = request.points?.map { point -> NetCoord in
            return NetCoord(lat: point.lat, lng: point.lng)
        }
        
        let networkRequest = NetReqTaxiTariff(
            coords: netPoints ?? [],
            options: request.optionIds ?? [],
            tariff: request.tariffId,
            address: request.addressId
        )
        
        let result = try await gateway.calculateRouteAndTariffs(
            req: networkRequest
        )
        
        let tariffItems = (result.tariffs ?? []).compactMap(TaxiTariff.init)
        
        return RouteTariffCalcResponse(
            map: .init(res: result.map),
            tariffs: tariffItems
        )
    }
}

extension NetResRouteCoordsItem {
    var coordinate: CLLocation {
        return .init(latitude: latitude, longitude: longitude)
    }
}

extension CLLocationCoordinate2D {
    var floatCoord: NetCoord {
        return .init(lat: latitude, lng: longitude)
    }
}

extension Coord {
    var res: NetCoord {
        .init(lat: lat, lng: lng)
    }
}
