//
//  AddCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/AddCardUseCase.swift
import Foundation

public protocol AddCardUseCaseProtocol {
    func execute(request: CardAddRequest) async throws -> CardAddResponse?
}

public final class AddCardUseCase: AddCardUseCaseProtocol {
    private let gateway: AddCardGatewayProtocol
    
    init(gateway: AddCardGatewayProtocol = AddCardGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = AddCardGateway()
    }
    
    public func execute(request: CardAddRequest) async throws -> CardAddResponse? {
        let result = try await gateway.addCard(
            cardNumber: request.cardNumber,
            expiry: request.expiry
        )
        
        return result.map { CardAddResponse(networkResponse: $0) }
    }
}
