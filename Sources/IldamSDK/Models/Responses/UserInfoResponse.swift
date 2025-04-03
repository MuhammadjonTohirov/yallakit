//
//  UserInfoResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// UserInfoResponse.swift
import Foundation
import Core

public struct UserInfoResponse {
    public let userInfo: UserInfo?
    public let expiresIn: Int
    
    init(networkResponse: NetResMeInfo) {
        self.userInfo = UserInfo.create(withResponse: networkResponse.client)
        self.expiresIn = networkResponse.expiresIn
    }
    
    public init(userInfo: UserInfo? = nil, expiresIn: Int = 0) {
        self.userInfo = userInfo
        self.expiresIn = expiresIn
    }
}
