//
//  SendOTPUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// SendOTPUseCase.swift
import Foundation

public protocol SendOTPUseCaseProtocol: Sendable {
    func execute(username: String) async throws -> OTPResponse?
}

public struct SendOTPUseCase: SendOTPUseCaseProtocol, Sendable {
    private let gateway: SendOTPGatewayProtocol
    
    public init() {
        self.gateway = SendOTPGateway()
    }

    init(gateway: SendOTPGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(username: String) async throws -> OTPResponse? {
        let result = try await gateway.sendOTP(username: username)
        return result.map { OTPResponse(networkResponse: $0) }
    }
}
