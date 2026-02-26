//
//  AddMyPlaceUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/AddPlaceUseCase.swift
import Foundation

public protocol AddPlaceUseCaseProtocol: Sendable {
    func execute(request: AddPlaceRequest) async -> Bool
}

public struct AddPlaceUseCase: AddPlaceUseCaseProtocol, Sendable {
    private let gateway: AddPlaceGatewayProtocol

    public init() {
        self.gateway = AddPlaceGateway()
    }

    init(gateway: AddPlaceGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(request: AddPlaceRequest) async -> Bool {
        return await gateway.addMyPlace(req: request.toNetworkRequest())
    }
}
