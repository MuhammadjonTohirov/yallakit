//
//  ArchivedOrdersUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ArchivedOrderUseCase.swift
import Foundation

public protocol ArchivedOrderUseCaseProtocol {
    func execute(id: Int) async throws -> OrderDetails?
}

public final class ArchivedOrderUseCase: ArchivedOrderUseCaseProtocol {
    private let gateway: ArchivedOrderGatewayProtocol
    
    init(gateway: ArchivedOrderGatewayProtocol = ArchivedOrderGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ArchivedOrderGateway()
    }
    
    public func execute(id: Int) async throws -> OrderDetails? {
        let result = try await gateway.getArchivedOrder(id: id)
        return OrderDetails(res: result)
    }
}
