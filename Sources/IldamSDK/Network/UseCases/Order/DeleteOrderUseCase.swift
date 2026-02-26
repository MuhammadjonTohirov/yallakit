//
//  DeleteOrderUseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation

public protocol DeleteOrderUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> Bool
}

public struct DeleteOrderUseCase: DeleteOrderUseCaseProtocol, Sendable {
    private let gateway: DeleteOrderGatewayProtocol

    public init() {
        self.gateway = DeleteOrderGateway()
    }

    init(gateway: DeleteOrderGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(id: Int) async throws -> Bool {
        return try await gateway.delete(id: id)
    }
}
