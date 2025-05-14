//
//  SendCoordsUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol SendCoordsUseCaseProtocol {
    func sendCoords(coords: SendCoordsBody) async throws -> Bool?
}

public final class SendCoordsUseCase: SendCoordsUseCaseProtocol {
    
    private var gateway: DriverSendCoordProtocol
    
    init(gateway: DriverSendCoordProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverSendCoordGateway()
    }
    
    public func sendCoords(coords: SendCoordsBody) async throws -> Bool? {
        let result = try await gateway.sendCoords(coords: coords)
        
        return result
    }
}
