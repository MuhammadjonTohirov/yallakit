//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/05/25.
//

import Foundation

public struct Constants: Sendable {
    public var baseGoApi: String = "https://api2.ildam.uz"
    public var basePhpApi: String = "https://api.ildam.uz"
    
    public var goBaseEndpoint: String = "/client"
    public var phpBaseEndpoint: String = "/cli"
    
    public var suiteName: String = "uz.xcoder.Ildam"
    public var appVersion: String = "2.2.404"
    
    public init() {}
    
    @discardableResult
    public func setBaseGoApi(_ baseGoApi: String) -> Self {
        var result = self
        result.baseGoApi = baseGoApi
        return result
    }
    
    @discardableResult
    public func setBasePhpApi(_ basePhpApi: String) -> Self {
        var result = self
        result.basePhpApi = basePhpApi
        return result
    }
    
    @discardableResult
    public func setSuiteName(_ suiteName: String) -> Self {
        var result = self
        result.suiteName = suiteName
        return result
    }
    
    @discardableResult
    public func setGoBaseEndpoint(_ goBaseEndpoint: String) -> Self {
        var result = self
        result.goBaseEndpoint = goBaseEndpoint
        return result
    }
    
    @discardableResult
    public func setPhpBaseEndpoint(_ phpBaseEndpoint: String) -> Self {
        var result = self
        result.phpBaseEndpoint = phpBaseEndpoint
        return result
    }
    
    @discardableResult
    public func setAppVersion(_ appVersion: String) -> Self {
        var result = self
        result.appVersion = appVersion
        return result
    }
}

public struct ConstantsProvider: Sendable {
    nonisolated(unsafe) public static var shared: ConstantsProvider = .init()
    
    public private(set) var constants: Constants = .init()
    
    mutating
    public func setConstants(_ constants: Constants) {
        self.constants = constants
    }
}
