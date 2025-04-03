//
//  ValidationResponse.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// ValidationResponse.swift
import Foundation
import Core

public struct ValidationResponse {
    public let isClient: Bool
    public let accessToken: String?
    public let expiresIn: Int?
    public let key: String?
    public let userInfo: UserInfo?
    
    init(networkResponse: NetResValidate) {
        self.isClient = networkResponse.isClient
        self.accessToken = networkResponse.accessToken
        self.expiresIn = networkResponse.expiresIn
        self.key = networkResponse.key
        self.userInfo = networkResponse.client.map { UserInfo.create(withResponse: $0) }
    }
    
    public init (isClient: Bool, accessToken: String? = nil, expiresIn: Int? = nil, key: String? = nil, userInfo: UserInfo? = nil) {
        self.isClient = isClient
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.key = key
        self.userInfo = userInfo
    }
}
