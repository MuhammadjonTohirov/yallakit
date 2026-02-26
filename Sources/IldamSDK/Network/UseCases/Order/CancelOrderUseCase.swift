//
//  CancelOrderUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/CancelOrderUseCase.swift
import Foundation

public protocol CancelOrderUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> Bool
}

public struct CancelOrderUseCase: CancelOrderUseCaseProtocol, Sendable {
    private let gateway: CancelOrderGatewayProtocol

    public init() {
        self.gateway = CancelOrderGateway()
    }

    init(gateway: CancelOrderGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(id: Int) async throws -> Bool {
        return try await gateway.cancelOrder(id: id)
    }
}
