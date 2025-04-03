//
//  ActiveOrdersCountUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ActiveOrdersCountUseCase.swift
import Foundation

public protocol ActiveOrdersCountUseCaseProtocol {
    func execute() async throws -> Int
}

public final class ActiveOrdersCountUseCase: ActiveOrdersCountUseCaseProtocol {
    private let gateway: ActiveOrdersCountGatewayProtocol
    
    init(gateway: ActiveOrdersCountGatewayProtocol = ActiveOrdersCountGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ActiveOrdersCountGateway()
    }
    
    public func execute() async throws -> Int {
        return try await gateway.getActiveOrdersCount() ?? 0
    }
}
