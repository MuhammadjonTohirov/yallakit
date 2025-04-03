//
//  MainNetworkService.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import Core
import NetworkLayer

public protocol MainNetworkServiceProtocl {
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

public struct MainNetworkService: MainNetworkServiceProtocl {
    
    public func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int?, options: [Int]?) async -> [TaxiTariff] {
        let result = try? await RouteTariffCalcUseCase().execute(
            request: .init(
                points: coords.map { .init(lat: $0.lat, lng: $0.lng) },
                optionIds: options,
                addressId: addressId
            )
        )
        
        return result?.tariffs ?? []
    }
    
    public func loadAddress(text: String) async -> [SearchAddressItem]? {
        await SearchAddressUseCase().execute(text: text)
    }
    
    public func loadNearAddress(lat: Double, lng: Double) async -> [SearchAddressItem] {
        await LoadNearAddressUseCase().execute(lat: lat, lng: lng)
    }
    
    public func loadMyPlaces() async -> [MyPlaceItem] {
        await LoadMyPlacesUseCase().execute()
    }
    
    public func loadHistory(page: Int, limit: Int = 8) async -> OrderHistoryResponse? {
        await LoadOrderHistoryUseCase().execute(page: page, limit: limit)
    }
    
    public func addMyPlace(req: AddPlaceRequest) async -> Bool {
        await AddPlaceUseCase().execute(request: req)
    }
    
    public func updateMyPlace(req: UpdatePlaceRequest) async -> Bool {
        await UpdatePlaceUseCase().execute(request: req)
    }
    
    public func calculateRouteAndTariffs(
        coords: [Coord],
        options: [Int],
        addressId: Int?,
        tariffId: Int?
    ) async throws -> (map: Core.RouteData?, tariffs: [TaxiTariff]?) {
        let result = try await RouteTariffCalcUseCase().execute(request: .init(
            points: coords.map {.init(lat: $0.lat, lng: $0.lng)},
            optionIds: options,
            addressId: addressId,
            tariffId: tariffId
        ))
        
        return (result?.map, result?.tariffs)
    }
    
    public func deleteAddress(id: Int) async -> Bool {
        await DeleteAddressUseCase().execute(id: id)
    }
    
    public func findExecutors(tariffId: Int?, options: [Int], coord: Coord) async -> TaxiExecutors? {
        await FindExecutorsUseCase().getExecutors(
            tariffId: tariffId,
            lat: coord.lat,
            lng: coord.lng,
            options: options
        )
    }
   
    public func getOrderDetails(orderId: Int) async throws -> OrderDetails? {
        try await GetOrderDetailsUseCase().execute(orderId: orderId)
    }
}
