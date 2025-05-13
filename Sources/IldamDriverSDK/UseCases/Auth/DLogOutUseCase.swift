//
//  DLogOutUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation

public protocol DLogOutUseCaseProtocol {
    func excute() async throws -> Bool?
}

public final class DLogOutUseCase: DLogOutUseCaseProtocol {
    private let gateway: any DriverLogOutProtocol
    
    init(gateway:DriverLogOutProtocol = DriverLogOutGateway() ) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverLogOutGateway()
    }
    
    public func excute() async throws -> Bool? {
        
        guard let result = try await gateway.logut() else {
            return false
        }
        
        return result
    }
}
