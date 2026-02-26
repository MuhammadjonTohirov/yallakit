//
//  LoadNearAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/LoadNearAddressUseCase.swift
import Foundation

public protocol LoadNearAddressUseCaseProtocol: Sendable {
    func execute(lat: Double, lng: Double) async -> [SearchAddressItem]
}

public struct LoadNearAddressUseCase: LoadNearAddressUseCaseProtocol, Sendable {
    private let gateway: LoadNearAddressGatewayProtocol

    public init() {
        self.gateway = LoadNearAddressGateway()
    }

    init(gateway: LoadNearAddressGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(lat: Double, lng: Double) async -> [SearchAddressItem] {
        let result = await gateway.loadNearAddress(lat: lat, lng: lng)
        return result.map { SearchAddressItem(networkResponse: $0) }
    }
}
