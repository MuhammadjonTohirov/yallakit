//
//  ActiveOrdersUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ActiveOrdersUseCase.swift
import Foundation

public protocol ActiveOrdersUseCaseProtocol {
    func execute() async throws -> [OrderDetails]
}

public final class ActiveOrdersUseCase: ActiveOrdersUseCaseProtocol {
    private let gateway: ActiveOrdersGatewayProtocol
    
    init(gateway: ActiveOrdersGatewayProtocol = ActiveOrdersGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ActiveOrdersGateway()
    }
    
    public func execute() async throws -> [OrderDetails] {
        let networkResult = try await gateway.getActiveOrders()
        return networkResult?.compactMap { OrderDetails(res: $0) } ?? []
    }
}
