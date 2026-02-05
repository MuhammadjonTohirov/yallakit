//
//  URL+Request.swift
//  YuzPay
//
//  Created by applebro on 15/02/23.
//

import Foundation
import UIKit.UIDevice

public struct URLRequestExtraHeaders: Sendable {
    
    static public var xPosition: String? {
        get {
            @codableWrapper(key: "xPosition")
            var position: String?
            
            return position
        }
        
        set {
            @codableWrapper(key: "xPosition")
            var position: String?
            
            position = newValue
        }
    }
    
    static public var lastPickedPosition: String? {
        get {
            @codableWrapper(key: "lastPickedPosition")
            var position: String?
            
            return position
        }
        
        set {
            @codableWrapper(key: "lastPickedPosition")
            var position: String?
            
            position = newValue
        }
    }
}

extension URLRequest {
    private static let appVersion: String = {
        ConstantsProvider.shared.constants.appVersion
    }()
    
    private static var brandId: Int? {
        ConstantsProvider.shared.constants.brandId
    }
    
    /// This method helps to create a urlrequest object with headers related to this application
    public static func new(url: URL, policy: CachePolicy = .useProtocolCachePolicy, withAuth: Bool = true, interval: TimeInterval = 60.0) -> URLRequest {
        var req = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
        req.addValue(URL.langHeader.value, forHTTPHeaderField: URL.langHeader.key)
        req.addValue(URL.keyHeader.value, forHTTPHeaderField: URL.keyHeader.key)

        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "accept")
        req.addValue("ios", forHTTPHeaderField: "User-Agent-OS")
        req.addValue(appVersion, forHTTPHeaderField: "User-Agent-Version")
        
        if let brandId {
            req.addValue("\(brandId)", forHTTPHeaderField: "brand-id")
        }
        
        if let accessToken = UserSettings.shared.accessToken, withAuth {
            req.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let xPosition = URLRequestExtraHeaders.lastPickedPosition ?? URLRequestExtraHeaders.xPosition {
            req.addValue(xPosition, forHTTPHeaderField: "x-position")
        }
        return req
    }
    
    public static func fromDataRequest(url: URL, boundary: String, policy: CachePolicy = .useProtocolCachePolicy, interval: TimeInterval = 60.0, withAuth: Bool = true) -> URLRequest {
        var req = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
        req.addValue(URL.langHeader.value, forHTTPHeaderField: URL.langHeader.key)

        req.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "accept")
        req.addValue("ios", forHTTPHeaderField: "User-Agent-OS")
        
        if let accessToken = UserSettings.shared.accessToken, withAuth {
            req.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let xPosition = URLRequestExtraHeaders.lastPickedPosition ?? URLRequestExtraHeaders.xPosition {
            req.addValue(xPosition, forHTTPHeaderField: "x-position")
        }
        return req
    }
}
