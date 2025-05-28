//
//  URL+Request.swift
//  YuzPay
//
//  Created by applebro on 15/02/23.
//

import Foundation
import UIKit.UIDevice

public extension URLRequest {
    static var extraHeaders: [String: String] {
        [:]
    }
}

extension URLRequest {
    private static let appVersion: String = {
        ConstantsProvider.shared.constants.appVersion
    }()
    
    /// This method helps to create a urlrequest object with headers related to this application
    public static func new(url: URL, policy: CachePolicy = .useProtocolCachePolicy, withAuth: Bool = true, interval: TimeInterval = 60.0) -> URLRequest {
        var req = URLRequest(url: url, cachePolicy: policy, timeoutInterval: interval)
        req.addValue(URL.langHeader.value, forHTTPHeaderField: URL.langHeader.key)
        req.addValue(URL.keyHeader.value, forHTTPHeaderField: URL.keyHeader.key)

        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "accept")
        req.addValue("ios", forHTTPHeaderField: "User-Agent-OS")
        req.addValue(appVersion, forHTTPHeaderField: "User-Agent-Version")
        
        if let accessToken = UserSettings.shared.accessToken, withAuth {
            req.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLRequest.extraHeaders.forEach { headerItem in
            req.addValue(headerItem.value, forHTTPHeaderField: headerItem.key)
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
        
        return req
    }
}
