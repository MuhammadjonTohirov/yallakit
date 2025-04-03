//
//  UpdatePlaceUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/UpdatePlaceUseCase.swift
import Foundation

public protocol UpdatePlaceUseCaseProtocol {
    func execute(request: UpdatePlaceRequest) async -> Bool
}

public final class UpdatePlaceUseCase: UpdatePlaceUseCaseProtocol {
    private let gateway: UpdatePlaceGatewayProtocol
    
    init(gateway: UpdatePlaceGatewayProtocol = UpdatePlaceGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdatePlaceGateway()
    }
    
    public func execute(request: UpdatePlaceRequest) async -> Bool {
        return await gateway.updateMyPlace(req: request.toNetworkRequest(), id: request.id)
    }
}
