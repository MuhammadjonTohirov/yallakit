//
//  ActiveOrdersUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ActiveOrdersUseCase.swift
import Foundation

public protocol ActiveOrdersUseCaseProtocol: Sendable {
    func execute() async throws -> [OrderDetails]
}

public struct ActiveOrdersUseCase: ActiveOrdersUseCaseProtocol, Sendable {
    private let gateway: ActiveOrdersGatewayProtocol

    public init() {
        self.gateway = ActiveOrdersGateway()
    }

    init(gateway: ActiveOrdersGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> [OrderDetails] {
        let networkResult = try await gateway.getActiveOrders()
        return networkResult?.compactMap { OrderDetails(res: $0) } ?? []
    }
}
