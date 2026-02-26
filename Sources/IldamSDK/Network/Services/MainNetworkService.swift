//
//  MainNetworkService.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import Core
import NetworkLayer

@available(*, deprecated, renamed: "MainNetworkServiceProtocol")
public typealias MainNetworkServiceProtocl = MainNetworkServiceProtocol

public protocol MainNetworkServiceProtocol: Sendable {
    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int?, options: [Int]?) async -> [TaxiTariff]

    func loadAddress(text: String) async -> [SearchAddressItem]?

    func loadNearAddress(lat: Double, lng: Double) async -> [SearchAddressItem]

    func loadMyPlaces() async -> [MyPlaceItem]

    func loadHistory(page: Int, limit: Int) async -> OrderHistoryResponse?

    func addMyPlace(req: AddPlaceRequest) async -> Bool

    func updateMyPlace(req: UpdatePlaceRequest) async -> Bool

    func calculateRouteAndTariffs(
        coords: [Coord],
        options: [Int],
        addressId: Int?,
        tariffId: Int?
    ) async throws -> (map: RouteData?, tariffs: [TaxiTariff]?)

    func deleteAddress(id: Int) async -> Bool

    func findExecutors(tariffId: Int?, options: [Int], coord: Coord) async -> TaxiExecutors?

    func getOrderDetails(orderId: Int) async throws -> OrderDetails?
}

public extension MainNetworkServiceProtocol {
    func getTaxiTariffs(coords: [Coord], addressId: Int?, options: [Int]?) async -> [TaxiTariff] {
        await getTaxiTariffs(coords: coords.map { ($0.lat, $0.lng) }, addressId: addressId, options: options)
    }
}

public struct MainNetworkService: MainNetworkServiceProtocol, Sendable {
    public static let shared = MainNetworkService()

    private let addressService: AddressNetworkServiceProtocol
    private let tariffService: TariffNetworkServiceProtocol
    private let executorService: ExecutorNetworkServiceProtocol
    private let orderHistoryUseCase: LoadOrderHistoryUseCaseProtocol
    private let orderDetailsUseCase: GetOrderDetailsUseCaseProtocol

    public init(
        addressService: AddressNetworkServiceProtocol = AddressNetworkService(),
        tariffService: TariffNetworkServiceProtocol = TariffNetworkService(),
        executorService: ExecutorNetworkServiceProtocol = ExecutorNetworkService(),
        orderHistoryUseCase: LoadOrderHistoryUseCaseProtocol = LoadOrderHistoryUseCase(),
        orderDetailsUseCase: GetOrderDetailsUseCaseProtocol = GetOrderDetailsUseCase()
    ) {
        self.addressService = addressService
        self.tariffService = tariffService
        self.executorService = executorService
        self.orderHistoryUseCase = orderHistoryUseCase
        self.orderDetailsUseCase = orderDetailsUseCase
    }

    // MARK: - Address (delegated)

    public func loadAddress(text: String) async -> [SearchAddressItem]? {
        await addressService.loadAddress(text: text)
    }

    public func loadNearAddress(lat: Double, lng: Double) async -> [SearchAddressItem] {
        await addressService.loadNearAddress(lat: lat, lng: lng)
    }

    public func loadMyPlaces() async -> [MyPlaceItem] {
        await addressService.loadMyPlaces()
    }

    public func addMyPlace(req: AddPlaceRequest) async -> Bool {
        await addressService.addMyPlace(req: req)
    }

    public func updateMyPlace(req: UpdatePlaceRequest) async -> Bool {
        await addressService.updateMyPlace(req: req)
    }

    public func deleteAddress(id: Int) async -> Bool {
        await addressService.deleteAddress(id: id)
    }

    // MARK: - Tariff (delegated)

    public func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int?, options: [Int]?) async -> [TaxiTariff] {
        await tariffService.getTaxiTariffs(coords: coords, addressId: addressId, options: options)
    }

    public func calculateRouteAndTariffs(
        coords: [Coord],
        options: [Int],
        addressId: Int?,
        tariffId: Int?
    ) async throws -> (map: Core.RouteData?, tariffs: [TaxiTariff]?) {
        try await tariffService.calculateRouteAndTariffs(
            coords: coords,
            options: options,
            addressId: addressId,
            tariffId: tariffId
        )
    }

    // MARK: - Executor (delegated)

    public func findExecutors(tariffId: Int?, options: [Int], coord: Coord) async -> TaxiExecutors? {
        await executorService.findExecutors(tariffId: tariffId, options: options, coord: coord)
    }

    // MARK: - Order (kept directly)

    public func loadHistory(page: Int, limit: Int = 8) async -> OrderHistoryResponse? {
        await orderHistoryUseCase.execute(page: page, limit: limit)
    }

    public func getOrderDetails(orderId: Int) async throws -> OrderDetails? {
        try await orderDetailsUseCase.execute(orderId: orderId)
    }
}
