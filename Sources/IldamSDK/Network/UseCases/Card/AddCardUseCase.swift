//
//  AddCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/AddCardUseCase.swift
import Foundation

public protocol AddCardUseCaseProtocol: Sendable {
    func execute(request: CardAddRequest) async throws -> CardAddResponse?
}

public struct AddCardUseCase: AddCardUseCaseProtocol, Sendable {
    private let gateway: AddCardGatewayProtocol

    public init() {
        self.gateway = AddCardGateway()
    }

    init(gateway: AddCardGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(request: CardAddRequest) async throws -> CardAddResponse? {
        let result = try await gateway.addCard(
            cardNumber: request.cardNumber,
            expiry: request.expiry
        )
        
        return result.map { CardAddResponse(networkResponse: $0) }
    }
}
