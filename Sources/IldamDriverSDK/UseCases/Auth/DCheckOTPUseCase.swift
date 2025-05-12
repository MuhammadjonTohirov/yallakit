//
//  DCheckOTPUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation

public protocol DCheckOTPUseCaseProtocol {
    func execute(code: String) async throws -> DriverOTPResponceValidateResponse?
}
public final class DCheckOTPUseCase: DCheckOTPUseCaseProtocol {
    private let gateway: any DCheckOTPUseCaseProtocol

    init(gateway: DCheckOTPUseCaseProtocol = DCheckOTPGateway() as! DCheckOTPUseCaseProtocol) {
        self.gateway = gateway
    }
    public init () {
        self.gateway = DCheckOTPGateway() as! any DCheckOTPUseCaseProtocol

    }
    public func execute(code: String) async throws -> DriverOTPResponceValidateResponse? {
        
        guard let result = try await gateway.execute(code: code) else {
            return nil
        }
        return DriverOTPResponceValidateResponse(
            accessToken: result.accessToken, tokenType: result.tokenType, expiresIn: result.expiresIn,
            executor: result.executor)
    }
}

