//
//  ActiveOrdersCountUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/ActiveOrdersCountUseCase.swift
import Foundation

public protocol ActiveOrdersCountUseCaseProtocol: Sendable {
    func execute() async throws -> Int
}

public struct ActiveOrdersCountUseCase: ActiveOrdersCountUseCaseProtocol, Sendable {
    private let gateway: ActiveOrdersCountGatewayProtocol

    public init() {
        self.gateway = ActiveOrdersCountGateway()
    }

    init(gateway: ActiveOrdersCountGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> Int {
        return try await gateway.getActiveOrdersCount() ?? 0
    }
}
