//
//  DriverActiveTransportUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverActiveTransportUseCaseProtocol {
    func execute(id:Int) async throws -> Bool
}

public final class DriverActiveTransportUseCase: DriverActiveTransportUseCaseProtocol {
    
    private let gateway: DriverActiveTransportProtocol
    
    init(gateway: DriverActiveTransportProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverActiveTransportGateway()
    }
    
    public func execute(id:Int) async throws -> Bool {
        
        guard let result = try await gateway.sendTransportId(id: id) else {
            return false
        }
        return true
    }
}
