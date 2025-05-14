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
    private let gateway: any DCheckOTPGatewayProtocol

    init(gateway: any DCheckOTPGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DCheckOTPGateway()
    }
    public func execute(code: String) async throws -> DriverOTPResponceValidateResponse? {
        
        guard let result = try await gateway.send(code: code) else {
            return nil
        }
        return DriverOTPResponceValidateResponse(from: result)
        
    }
}

