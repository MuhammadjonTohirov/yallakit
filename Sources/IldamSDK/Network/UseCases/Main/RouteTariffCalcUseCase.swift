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
        
        var lastError: Error?
        let maxRetries = 3
        let retryDelay: UInt64 = 1_000_000_000 // 1 second in nanoseconds
        
        for attempt in 1...maxRetries {
            do {
                let result = try await gateway.calculateRouteAndTariffs(
                    req: networkRequest
                )
                
                let tariffItems = (result?.tariff ?? []).compactMap(TaxiTariff.init)
                
                return RouteTariffCalcResponse(
                    map: .init(res: result?.map),
                    tariffs: tariffItems,
                    working: .init(result?.working)
                )
            } catch {
                lastError = error
                
                // If this is not the last attempt, wait before retrying
                if attempt < maxRetries {
                    try await Task.sleep(nanoseconds: retryDelay)
                }
            }
        }
        
        // If all retries failed, throw the last error
        throw lastError ?? NSError(domain: "RouteTariffCalcUseCase", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred after \(maxRetries) attempts"])
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
