//
//  AddMyPlaceUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/AddPlaceUseCase.swift
import Foundation

public protocol AddPlaceUseCaseProtocol {
    func execute(request: AddPlaceRequest) async -> Bool
}

public final class AddPlaceUseCase: AddPlaceUseCaseProtocol {
    private let gateway: AddPlaceGatewayProtocol
    
    init(gateway: AddPlaceGatewayProtocol = AddPlaceGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = AddPlaceGateway()
    }
    
    public func execute(request: AddPlaceRequest) async -> Bool {
        return await gateway.addMyPlace(req: request.toNetworkRequest())
    }
}
