//
//  LoadNearAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/LoadNearAddressUseCase.swift
import Foundation

public protocol LoadNearAddressUseCaseProtocol {
    func execute(lat: Double, lng: Double) async -> [SearchAddressItem]
}

public final class LoadNearAddressUseCase: LoadNearAddressUseCaseProtocol {
    private let gateway: LoadNearAddressGatewayProtocol
    
    init(gateway: LoadNearAddressGatewayProtocol = LoadNearAddressGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = LoadNearAddressGateway()
    }
    
    public func execute(lat: Double, lng: Double) async -> [SearchAddressItem] {
        let result = await gateway.loadNearAddress(lat: lat, lng: lng)
        return result.map { SearchAddressItem(networkResponse: $0) }
    }
}
