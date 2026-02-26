//
//  AddressNetworkService.swift
//  IldamSDK
//
//  Created on 26/02/26.
//

import Foundation
import Core
import NetworkLayer

public protocol AddressNetworkServiceProtocol: Sendable {
    func loadAddress(text: String) async -> [SearchAddressItem]?
    func loadNearAddress(lat: Double, lng: Double) async -> [SearchAddressItem]
    func loadMyPlaces() async -> [MyPlaceItem]
    func addMyPlace(req: AddPlaceRequest) async -> Bool
    func updateMyPlace(req: UpdatePlaceRequest) async -> Bool
    func deleteAddress(id: Int) async -> Bool
}

public struct AddressNetworkService: AddressNetworkServiceProtocol, Sendable {
    public static let shared: AddressNetworkServiceProtocol = AddressNetworkService()

    private let searchAddressUseCase: SearchAddressUseCaseProtocol
    private let loadNearAddressUseCase: LoadNearAddressUseCaseProtocol
    private let myPlacesUseCase: LoadMyPlacesUseCaseProtocol
    private let addPlaceUseCase: AddPlaceUseCaseProtocol
    private let updatePlaceUseCase: UpdatePlaceUseCaseProtocol
    private let deleteAddressUseCase: DeleteAddressUseCaseProtocol

    public init(
        searchAddressUseCase: SearchAddressUseCaseProtocol = SearchAddressUseCase(),
        loadNearAddressUseCase: LoadNearAddressUseCaseProtocol = LoadNearAddressUseCase(),
        myPlacesUseCase: LoadMyPlacesUseCaseProtocol = LoadMyPlacesUseCase(),
        addPlaceUseCase: AddPlaceUseCaseProtocol = AddPlaceUseCase(),
        updatePlaceUseCase: UpdatePlaceUseCaseProtocol = UpdatePlaceUseCase(),
        deleteAddressUseCase: DeleteAddressUseCaseProtocol = DeleteAddressUseCase()
    ) {
        self.searchAddressUseCase = searchAddressUseCase
        self.loadNearAddressUseCase = loadNearAddressUseCase
        self.myPlacesUseCase = myPlacesUseCase
        self.addPlaceUseCase = addPlaceUseCase
        self.updatePlaceUseCase = updatePlaceUseCase
        self.deleteAddressUseCase = deleteAddressUseCase
    }

    public func loadAddress(text: String) async -> [SearchAddressItem]? {
        await searchAddressUseCase.execute(text: text)
    }

    public func loadNearAddress(lat: Double, lng: Double) async -> [SearchAddressItem] {
        await loadNearAddressUseCase.execute(lat: lat, lng: lng)
    }

    public func loadMyPlaces() async -> [MyPlaceItem] {
        await myPlacesUseCase.execute()
    }

    public func addMyPlace(req: AddPlaceRequest) async -> Bool {
        await addPlaceUseCase.execute(request: req)
    }

    public func updateMyPlace(req: UpdatePlaceRequest) async -> Bool {
        await updatePlaceUseCase.execute(request: req)
    }

    public func deleteAddress(id: Int) async -> Bool {
        await deleteAddressUseCase.execute(id: id)
    }
}
