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

public struct UserSettings : Sendable {
    nonisolated(unsafe) public static var shared = UserSettings()
    
    public let userAvatarURL: URL = URL.baseAPICli.appendingPath("Client", "ProfileAvatar")
    
    public private(set) var testAccessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiZGMzY2UxZmRjNGYwYmI2MTc4NmFiMTIxMDY4YzA2OThhZWM1MzI4NzkwN2VhN2U3ODVhNzgxYTIyM2MyNDQ1YjlhN2U4OGY3YTI4MzUwMGQiLCJpYXQiOjE3NDMxNTQyNzUuMzIyNjk1LCJuYmYiOjE3NDMxNTQyNzUuMzIyNjk2LCJleHAiOjE3NzQ2OTAyNzUuMzE2NDY1LCJzdWIiOiIyNDIwMzUiLCJzY29wZXMiOlsiY2xpZW50Il19.yMYcmox4VN4bod0DqtEoP2n1gzOIMaZWUQjffb0YJHss_ob5eY2BATpyy5c6An2ohJ65LTa0BOPFaaUedCffu0KIhdM3f_srm58utWsYGvfNLAwryuVxOIe5rBLm_NVU9BrCZqvUZN-uWDcTx8JX8ElkWAvfTYMk6P5hT_aPgL8yDl4OwfkFU5FRXwvs93jXVrx7ChcjCR_e4aLZjnnzXHLWuY0ov5GHB9COy2ndbyKvpfG_SxFmlnwDz6bn21IkI2oUKcaktMEhStGSEH3NVZaq_nOgwH55KTqIEE8UOmgKmhuJGgkphTcZYw6iaG8AwY9LxyErX3ANtBazQ9gU_KEUwLCQZc92VlI8z_KrvSkMKxB_U-Hk6mDXPZeDZBokV0F5mruCX8gZ5vaNMoTFPzlgQi6SIquh01wngweU9d8_ExWdiZEihvz0qBl5H47ULQXx30i6tWTSi9iW5MvrHcH8HkCz8QZ3k2mbAOKdrxokeXG0uEk_oD00V_yH0KxFLGutdDOFtXCFBfKUQJEBLpP-Hay9FJfJzIyIsdBR8hFiy2nhUSkp16ME0tNhTWmMqd6Ys2kALzrmDzTQVYePMG_sq8oBPSTtSATjIChxAZoFaVKsB_3ifS8fPaIthwSFQ3Pw-TIb-aTTpqLiibSf2O3BcuUpcJbZv_WbOQN6P6Q"
    
    public var language: Language? {
        set {
            @codableWrapper(key: "language", Language.russian)
            var lang: Language?
            lang = newValue
        } get {
            @codableWrapper(key: "language", Language.russian)
            var language: Language?
            return language
        }
    }
    
    public var username: String? {
        set {
            @codableWrapper(key: "userEmail")
            var email: String?
            email = newValue
        }
        get {
            @codableWrapper(key: "userEmail")
            var email: String?
            return email
        }
    }
    
    public var accessToken: String? {
        set {
            @codableWrapper(key: "accessToken")
            var token: String?
            token = newValue
        }
        get {
            @codableWrapper(key: "accessToken")
            var token: String?
            return token
        }
    }
    
    public var refreshToken: String? {
        set {
            @codableWrapper(key: "refreshToken")
            var token: String?
            token = newValue
        }
        get {
            @codableWrapper(key: "refreshToken")
            var token: String?
            return token
        }
    }
    
    public var tokenExpireDate: Date? {
        set {
            @codableWrapper(key: "tokenExpireDate")
            var date: Date?
            date = newValue
        }
        get {
            @codableWrapper(key: "tokenExpireDate")
            var date: Date?
            return date
        }
    }
    
    public var lastActiveDate: Date? {
        set {
            @codableWrapper(key: "lastActiveDate")
            var date: Date?
            date = newValue
        }
        get {
            @codableWrapper(key: "lastActiveDate")
            var date: Date?
            return date
        }
    }
    
    public var appPin: String? {
        set {
            @codableWrapper(key: "appPin")
            var pin: String?
            pin = newValue
        }
        get {
            @codableWrapper(key: "appPin")
            var pin: String?
            return pin
        }
    }
    
    public var hasValidToken: Bool {
        // expire token will not be used for now, because there is no refresh token api
        return accessToken?.nilIfEmpty != nil && username?.nilIfEmpty != nil // && Date() < (tokenExpireDate ?? Date())
    }
    
    public var userInfo: UserInfo? {
        set {
            @codableWrapper(key: "userInfo")
            var info: UserInfo?
            info = newValue
        }
        get {
            @codableWrapper(key: "userInfo")
            var info: UserInfo?
            return info
        }
    }
    
    public var isLanguageSelected: Bool? {
        set {
            @codableWrapper(key: "isLanguageSelected", false)
            var selected: Bool?
            selected = newValue
        }
        get {
            @codableWrapper(key: "isLanguageSelected", false)
            var selected: Bool?
            return selected
        }
    }
    
    public var lastOTPKey: String? {
        set {
            @codableWrapper(key: "otpKey", nil)
            var key: String?
            key = newValue
        }
        get {
            @codableWrapper(key: "otpKey", nil)
            var key: String?
            return key
        }
    }
    
    public var session: String? {
        set {
            @codableWrapper(key: "session", nil)
            var sess: String?
            sess = newValue
        }
        get {
            @codableWrapper(key: "session", nil)
            var sess: String?
            return sess
        }
    }
    
    public var theme: AppTheme? {
        set {
            @codableWrapper(key: "theme", .system)
            var th: AppTheme?
            th = newValue
        }
        get {
            @codableWrapper(key: "theme", .system)
            var th: AppTheme?
            return th
        }
    }
    
    public var fcmToken: String? {
        set {
            @codableWrapper(key: "fcmToken", nil)
            var token: String?
            token = newValue
        }
        get {
            @codableWrapper(key: "fcmToken", nil)
            var token: String?
            return token
        }
    }
    
    public func setLanguage(_ lang: Language) {
        @codableWrapper(key: "language", Language.russian)
        var language: Language?
        language = lang
    }
    
    @MainActor public func set(interfaceStyle: UIUserInterfaceStyle) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.forEach({ window in
            window.overrideUserInterfaceStyle = interfaceStyle
        })
    }
    
    public mutating func setupForTest() {
        self.accessToken = self.testAccessToken
        self.username = "998935852415"
    }
    
    public mutating func clear() {
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
