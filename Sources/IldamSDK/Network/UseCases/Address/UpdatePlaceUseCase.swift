//
//  UpdatePlaceUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/UpdatePlaceUseCase.swift
import Foundation

public protocol UpdatePlaceUseCaseProtocol: Sendable {
    func execute(request: UpdatePlaceRequest) async -> Bool
}

public struct UpdatePlaceUseCase: UpdatePlaceUseCaseProtocol, Sendable {
    private let gateway: UpdatePlaceGatewayProtocol

    public init() {
        self.gateway = UpdatePlaceGateway()
    }

    init(gateway: UpdatePlaceGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(request: UpdatePlaceRequest) async -> Bool {
        return await gateway.updateMyPlace(req: request.toNetworkRequest(), id: request.id)
    }
}
