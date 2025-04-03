//
//  SendOTPUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// SendOTPUseCase.swift
import Foundation

public protocol SendOTPUseCaseProtocol {
    func execute(username: String) async throws -> OTPResponse?
}

public final class SendOTPUseCase: SendOTPUseCaseProtocol {
    private let gateway: SendOTPGatewayProtocol
    
    init(gateway: SendOTPGatewayProtocol = SendOTPGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = SendOTPGateway()
    }
    
    public func execute(username: String) async throws -> OTPResponse? {
        let result = try await gateway.sendOTP(username: username)
        return result.map { OTPResponse(networkResponse: $0) }
    }
}
