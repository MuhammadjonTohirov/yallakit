//
//  Driverd.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverSendCoordsUseCaseProtocol {
    func execute(coords: SendCoordsBody) async throws -> Bool
}

public final class DriverSendCoordsUseCase: DriverSendCoordsUseCaseProtocol {
    private let gateway: DriverSendCoordProtocol
    
    init(gateway: DriverSendCoordProtocol) {
        self.gateway = gateway
    }
    
    public init () {
        self.gateway = DriverSendCoordGateway()
    }

    public func execute(coords: SendCoordsBody) async throws -> Bool {
        guard let result = try? await gateway.sendCoords(coords: coords)
        else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        
        return result
    }
    
}

