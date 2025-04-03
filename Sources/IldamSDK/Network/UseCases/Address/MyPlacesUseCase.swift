//
//  MyPlacesUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/LoadMyPlacesUseCase.swift
import Foundation

public protocol LoadMyPlacesUseCaseProtocol {
    func execute() async -> [MyPlaceItem]
}

public final class LoadMyPlacesUseCase: LoadMyPlacesUseCaseProtocol {
    private let gateway: MyPlacesGatewayProtocol
    
    init(gateway: MyPlacesGatewayProtocol = MyPlacesGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = MyPlacesGateway()
    }
    
    public func execute() async -> [MyPlaceItem] {
        let result = await gateway.loadMyPlaces()
        return result.map { MyPlaceItem(networkResponse: $0) }
    }
}
