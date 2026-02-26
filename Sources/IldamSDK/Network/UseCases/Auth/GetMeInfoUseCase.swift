//
//  GetMeInfoUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// GetMeInfoUseCase.swift
import Foundation

public protocol GetMeInfoUseCaseProtocol: Sendable {
    func execute() async -> UserInfoResponse?
}

public struct GetMeInfoUseCase: GetMeInfoUseCaseProtocol, Sendable {
    private let gateway: GetMeInfoGatewayProtocol

    public init() {
        self.gateway = GetMeInfoGateway()
    }

    init(gateway: GetMeInfoGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async -> UserInfoResponse? {
        guard let result = await gateway.getMeInfo() else {
            return nil
        }
        
        return UserInfoResponse(networkResponse: result)
    }
}
