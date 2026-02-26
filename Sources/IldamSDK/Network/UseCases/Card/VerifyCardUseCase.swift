//
//  VerifyCardUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/VerifyCardUseCase.swift
import Foundation

public protocol VerifyCardUseCaseProtocol: Sendable {
    func execute(request: CardVerifyRequest) async throws -> Bool
}

public struct VerifyCardUseCase: VerifyCardUseCaseProtocol, Sendable {
    private let gateway: VerifyCardGatewayProtocol

    public init() {
        self.gateway = VerifyCardGateway()
    }

    init(gateway: VerifyCardGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(request: CardVerifyRequest) async throws -> Bool {
        let result = try await gateway.verifyCard(key: request.key, code: request.code)
        return result ?? false
    }
}
