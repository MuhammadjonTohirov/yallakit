//
//  AuthTokenStore.swift
//  Core
//
//  Created by YallaKit on 26/02/26.
//

import Foundation

public protocol AuthTokenStoreProtocol: AnyObject {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    var tokenExpireDate: Date? { get set }
    var hasValidToken: Bool { get }
}

extension UserSettings: AuthTokenStoreProtocol {}
