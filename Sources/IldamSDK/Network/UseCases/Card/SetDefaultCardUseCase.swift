//
//  SelectDefaultCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/SetDefaultCardUseCase.swift
import Foundation

public protocol SetDefaultCardUseCaseProtocol: Sendable {
    func execute(cardId: String) async throws -> Bool
}

public struct SetDefaultCardUseCase: SetDefaultCardUseCaseProtocol, Sendable {
    private let gateway: SelectDefaultCardGatewayProtocol

    public init() {
        self.gateway = SelectDefaultCardGateway()
    }

    init(gateway: SelectDefaultCardGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(cardId: String) async throws -> Bool {
        return try await gateway.selectDefaultCard(cardId: cardId)
    }
}
