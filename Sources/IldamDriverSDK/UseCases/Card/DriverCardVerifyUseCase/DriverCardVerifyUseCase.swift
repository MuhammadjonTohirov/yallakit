//
//  DriverCardVerifyUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol DriverCardVerifyUseCaseProtocol {
    func verifyCode(key: String, confirm_code: String) async throws -> CardVerificaitonResponse
}

public final class DriverCardVerifyUseCase: DriverCardVerifyUseCaseProtocol {
    
    private var gateway: DriverCardVerificationProtocol
    
    init(gateway: DriverCardVerificationProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverCardVerificationGateway()
    }
    
    public func verifyCode(key: String, confirm_code: String) async throws -> CardVerificaitonResponse {
        
        guard let result = try await gateway.sendCode(key: key, confirm_code: confirm_code) else {
            throw NSError(domain: "Card verify Code not found", code: -1)
        }
        return CardVerificaitonResponse(from: result)
    }
}
