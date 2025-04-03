//
//  CancelOrderUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/CancelOrderUseCase.swift
import Foundation

public protocol CancelOrderUseCaseProtocol {
    func execute(id: Int) async throws -> Bool
}

public final class CancelOrderUseCase: CancelOrderUseCaseProtocol {
    private let gateway: CancelOrderGatewayProtocol
    
    init(gateway: CancelOrderGatewayProtocol = CancelOrderGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = CancelOrderGateway()
    }
    
    public func execute(id: Int) async throws -> Bool {
        return try await gateway.cancelOrder(id: id)
    }
}
