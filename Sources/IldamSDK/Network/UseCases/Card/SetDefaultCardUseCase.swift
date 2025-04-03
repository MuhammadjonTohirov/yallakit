//
//  SelectDefaultCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/SetDefaultCardUseCase.swift
import Foundation

public protocol SetDefaultCardUseCaseProtocol {
    func execute(cardId: String) async throws -> Bool
}

public final class SetDefaultCardUseCase: SetDefaultCardUseCaseProtocol {
    private let gateway: SelectDefaultCardGatewayProtocol
    
    init(gateway: SelectDefaultCardGatewayProtocol = SelectDefaultCardGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = SelectDefaultCardGateway()
    }
    
    public func execute(cardId: String) async throws -> Bool {
        return try await gateway.selectDefaultCard(cardId: cardId)
    }
}
