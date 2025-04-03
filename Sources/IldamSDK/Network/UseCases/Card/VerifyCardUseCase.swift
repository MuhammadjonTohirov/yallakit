//
//  VerifyCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/VerifyCardUseCase.swift
import Foundation

public protocol VerifyCardUseCaseProtocol {
    func execute(request: CardVerifyRequest) async throws -> Bool
}

public final class VerifyCardUseCase: VerifyCardUseCaseProtocol {
    private let gateway: VerifyCardGatewayProtocol
    
    init(gateway: VerifyCardGatewayProtocol = VerifyCardGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = VerifyCardGateway()
    }
    
    public func execute(request: CardVerifyRequest) async throws -> Bool {
        let result = try await gateway.verifyCard(key: request.key, code: request.code)
        return result ?? false
    }
}
