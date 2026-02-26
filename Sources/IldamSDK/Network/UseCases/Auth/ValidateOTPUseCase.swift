//
//  ValidateOTPUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// ValidateOTPUseCase.swift
import Foundation
import Core

public protocol ValidateOTPUseCaseProtocol: Sendable {
    func execute(username: String, code: String) async -> ValidationResponse?
}

public struct ValidateOTPUseCase: ValidateOTPUseCaseProtocol, Sendable {
    private let gateway: ValidateOTPGatewayProtocol

    public init() {
        self.gateway = ValidateOTPGateway()
    }

    init(gateway: ValidateOTPGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(username: String, code: String) async -> ValidationResponse? {
        let result = await gateway.validate(username: username, code: code)
        
        if let result = result {
            // Save user information
            UserSettings.shared.lastOTPKey = result.key
            
            if let token = result.accessToken {
                UserSettings.shared.accessToken = token
                UserSettings.shared.tokenExpireDate = result.expirationDate
                
                if let client = result.client {
                    UserSettings.shared.userInfo = .create(withResponse: client)
                }
            }
            
            return ValidationResponse(networkResponse: result)
        }
        
        return nil
    }
}

extension UserInfo {
    static func create(withResponse res: NetResClient) -> UserInfo {
        UserInfo(id: res.id, phone: res.phone, givenNames: res.givenNames, surName: res.surName, block: res.block, orderCount: res.orderCount, balance: res.balance, busyBalance: res.busyBalance, blockNote: res.blockNote, rating: res.rating, blockDate: res.blockDate, blockSource: res.blockSource, image: res.image, blockExpiry: res.blockExpiry, services: res.services, createdAt: res.createdAt, lastActivity: res.lastActivity, birthday: res.birthday, gender: res.gender?.rawValue)
    }
}
