//
//  GetMeInfoUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// GetMeInfoUseCase.swift
import Foundation

public protocol GetMeInfoUseCaseProtocol {
    func execute() async -> UserInfoResponse?
}

public final class GetMeInfoUseCase: GetMeInfoUseCaseProtocol {
    private let gateway: GetMeInfoGatewayProtocol
    
    init(gateway: GetMeInfoGatewayProtocol = GetMeInfoGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetMeInfoGateway()
    }
    
    public func execute() async -> UserInfoResponse? {
        guard let result = await gateway.getMeInfo() else {
            return nil
        }
        
        return UserInfoResponse(networkResponse: result)
    }
}
