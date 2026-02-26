//
//  TariffNetworkService.swift
//  IldamSDK
//
//  Created on 26/02/26.
//

import Foundation
import Core
import NetworkLayer

public protocol TariffNetworkServiceProtocol: Sendable {
    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int?, options: [Int]?) async -> [TaxiTariff]
    func calculateRouteAndTariffs(
        coords: [Coord],
        options: [Int],
        addressId: Int?,
        tariffId: Int?
    ) async throws -> (map: RouteData?, tariffs: [TaxiTariff]?)
}

public extension TariffNetworkServiceProtocol {
    func getTaxiTariffs(coords: [Coord], addressId: Int?, options: [Int]?) async -> [TaxiTariff] {
        await getTaxiTariffs(coords: coords.map { ($0.lat, $0.lng) }, addressId: addressId, options: options)
    }
}

public struct TariffNetworkService: TariffNetworkServiceProtocol, Sendable {
    public static let shared: TariffNetworkServiceProtocol = TariffNetworkService()

    private let routeTariffCalcUseCase: RouteTariffCalcUseCaseProtocol

    public init(
        routeTariffCalcUseCase: RouteTariffCalcUseCaseProtocol = RouteTariffCalcUseCase()
    ) {
        self.routeTariffCalcUseCase = routeTariffCalcUseCase
    }

    public func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int?, options: [Int]?) async -> [TaxiTariff] {
        let result = try? await routeTariffCalcUseCase.execute(
            request: .init(
                points: coords.map { .init(lat: $0.lat, lng: $0.lng) },
                optionIds: options,
                addressId: addressId
            )
        )
        return result?.tariffs ?? []
    }

    public func calculateRouteAndTariffs(
        coords: [Coord],
        options: [Int],
        addressId: Int?,
        tariffId: Int?
    ) async throws -> (map: Core.RouteData?, tariffs: [TaxiTariff]?) {
        let result = try await routeTariffCalcUseCase.execute(request: .init(
            points: coords.map { .init(lat: $0.lat, lng: $0.lng) },
            optionIds: options,
            addressId: addressId,
            tariffId: tariffId
        ))
        return (result?.map, result?.tariffs)
    }
}
