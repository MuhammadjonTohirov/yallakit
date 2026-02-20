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

public struct DeleteOrderUseCase: DeleteOrderUseCaseProtocol {
    private let gateway: DeleteOrderGatewayProtocol
    
    init(gateway: DeleteOrderGatewayProtocol = DeleteOrderGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DeleteOrderGateway()
    }
    
    public func execute(id: Int) async throws -> Bool {
        return try await gateway.delete(id: id)
    }
}
