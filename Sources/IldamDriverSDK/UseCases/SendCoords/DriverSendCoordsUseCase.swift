//
//  Driverd.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverSendCoordUseCaseProtocol {
    func sendCoords(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool) async throws -> Bool
    func sendCoords(body: SendCoordsBody) async throws -> Bool
}

public final class DriverSendCoordUseCase: DriverSendCoordUseCaseProtocol {
    
    private let gateway: any DriverSendCoordProtocol
    
    init(gateway: any DriverSendCoordProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverSendCoordGateway()
    }

    public func sendCoords(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool = false) async throws -> Bool {
        try await gateway.sendCoords(
            lat: lat, lng: lng,
            heading: heading,
            speed: speed,
            online: online
        )
    }

    public func sendCoords(body: SendCoordsBody) async throws -> Bool {
        try await gateway.sendCoords(
            request: body
        )
    }
}
