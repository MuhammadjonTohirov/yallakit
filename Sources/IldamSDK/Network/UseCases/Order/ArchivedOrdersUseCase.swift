//
//  ArchivedOrdersUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ArchivedOrderUseCase.swift
import Foundation

public protocol ArchivedOrderUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> OrderDetails?
}

public struct ArchivedOrderUseCase: ArchivedOrderUseCaseProtocol, Sendable {
    private let gateway: ArchivedOrderGatewayProtocol

    public init() {
        self.gateway = ArchivedOrderGateway()
    }

    init(gateway: ArchivedOrderGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(id: Int) async throws -> OrderDetails? {
        let result = try await gateway.getArchivedOrder(id: id)
        return OrderDetails(res: result)
    }
}
