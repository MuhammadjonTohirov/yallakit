//
//  UserSettings.swift
//  USDK
//
//  Created by applebro on 06/10/23.
//

import Foundation
import UIKit

public enum AppTheme: Codable {
    case system
    case light
    case dark
    
    public var name: String {
        switch self {
        case .system:
            return "system".localize
        case .light:
            return "light".localize
        case .dark:
            return "dark".localize
        }
    }
    
    public var style: UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

final public class UserSettings: @unchecked Sendable {
    public static let shared = UserSettings()
    
    public private(set) var userAvatarURL: URL = URL.baseAPICli.appendingPath("Client", "ProfileAvatar")
    
    public private(set) var testAccessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiZGMzY2UxZmRjNGYwYmI2MTc4NmFiMTIxMDY4YzA2OThhZWM1MzI4NzkwN2VhN2U3ODVhNzgxYTIyM2MyNDQ1YjlhN2U4OGY3YTI4MzUwMGQiLCJpYXQiOjE3NDMxNTQyNzUuMzIyNjk1LCJuYmYiOjE3NDMxNTQyNzUuMzIyNjk2LCJleHAiOjE3NzQ2OTAyNzUuMzE2NDY1LCJzdWIiOiIyNDIwMzUiLCJzY29wZXMiOlsiY2xpZW50Il19.yMYcmox4VN4bod0DqtEoP2n1gzOIMaZWUQjffb0YJHss_ob5eY2BATpyy5c6An2ohJ65LTa0BOPFaaUedCffu0KIhdM3f_srm58utWsYGvfNLAwryuVxOIe5rBLm_NVU9BrCZqvUZN-uWDcTx8JX8ElkWAvfTYMk6P5hT_aPgL8yDl4OwfkFU5FRXwvs93jXVrx7ChcjCR_e4aLZjnnzXHLWuY0ov5GHB9COy2ndbyKvpfG_SxFmlnwDz6bn21IkI2oUKcaktMEhStGSEH3NVZaq_nOgwH55KTqIEE8UOmgKmhuJGgkphTcZYw6iaG8AwY9LxyErX3ANtBazQ9gU_KEUwLCQZc92VlI8z_KrvSkMKxB_U-Hk6mDXPZeDZBokV0F5mruCX8gZ5vaNMoTFPzlgQi6SIquh01wngweU9d8_ExWdiZEihvz0qBl5H47ULQXx30i6tWTSi9iW5MvrHcH8HkCz8QZ3k2mbAOKdrxokeXG0uEk_oD00V_yH0KxFLGutdDOFtXCFBfKUQJEBLpP-Hay9FJfJzIyIsdBR8hFiy2nhUSkp16ME0tNhTWmMqd6Ys2kALzrmDzTQVYePMG_sq8oBPSTtSATjIChxAZoFaVKsB_3ifS8fPaIthwSFQ3Pw-TIb-aTTpqLiibSf2O3BcuUpcJbZv_WbOQN6P6Q"
    
    @codableWrapper(key: "language", Language.russian)
    public var language: Language?

    @codableWrapper(key: "userEmail")
    public var username: String?
    
    @codableWrapper(key: "accessToken")
    public var accessToken: String?
    
    @codableWrapper(key: "refreshToken")
    public var refreshToken: String?
    
    @codableWrapper(key: "tokenExpireDate")
    public var tokenExpireDate: Date?
    
    @codableWrapper(key: "lastActiveDate")
    public var lastActiveDate: Date?
    
    @codableWrapper(key: "appPin")
    public var appPin: String?
    
    public var hasValidToken: Bool {
        // expire token will not be used for now, because there is no refresh token api
        return accessToken?.nilIfEmpty != nil && username?.nilIfEmpty != nil // && Date() < (tokenExpireDate ?? Date())
    }
    
    @codableWrapper(key: "userInfo")
    public var userInfo: UserInfo?
    
    @codableWrapper(key: "isLanguageSelected", false)
    public var isLanguageSelected: Bool?
    
    @codableWrapper(key: "otpKey", nil)
    public var lastOTPKey: String?
    
    @codableWrapper(key: "session", nil)
    public var session: String?
    
    @codableWrapper(key: "theme", .system)
    public var theme: AppTheme?
    
    @codableWrapper(key: "fcmToken", nil)
    public var fcmToken: String?
    
    @MainActor
    public func set(interfaceStyle: UIUserInterfaceStyle) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.forEach({ window in
            window.overrideUserInterfaceStyle = interfaceStyle
        })
    }
    
    public func setupForTest() {
        self.accessToken = self.testAccessToken
        self.username = "998935852415"
    }
    
    public func clear() {
        accessToken = nil
        refreshToken = nil
        tokenExpireDate = nil
        lastActiveDate = nil
        appPin = nil
        isLanguageSelected = nil
        lastOTPKey = nil
        session = nil
        username = nil
        language = nil
    }
}
