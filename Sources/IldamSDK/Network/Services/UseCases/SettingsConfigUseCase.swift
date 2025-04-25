//
//  SettingsConfigUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 11/02/25.
//

import Foundation
import Core
import NetworkLayer

public protocol SettingsConfigUseCase {
    static var config: OrderConfigSettings? {get}
    
    func fetch() async throws -> OrderConfigSettings?
}

extension SettingsConfigUseCase {
    public static var config: OrderConfigSettings? {
        @codableWrapper(key: "settingsConfig", nil)
        var _config: OrderConfigSettings?
        
        return _config
    }
}

public struct SettingsConfigUseCaseImpl: SettingsConfigUseCase {
    public init() {
        
    }
    
    public func fetch() async throws -> OrderConfigSettings? {
        let result: NetRes<NetResOrderSettings>? = (try await Network.sendThrow(request: OrderNetworkRoute.orderSettings))
        
        @codableWrapper(key: "settingsConfig", nil)
        var config: NetResOrderSettings?
        config = result?.result
        
        return .init(res: result?.result)
    }
}
