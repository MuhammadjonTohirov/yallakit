//
//  Driverd.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol DriverSendCoordUseCaseProtocol {
    func sendLocationWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool?) async throws -> Bool
    func sendLocationWithOrder(body: SendCoordsBody) async throws -> Bool
}

public final class DriverSendCoordUseCase: DriverSendCoordUseCaseProtocol {
    
    private let gateway: DriverSendCoordProtocol
    
    init(gateway: DriverSendCoordProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverSendCoordGateway()
    }

    public func sendLocationWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool?) async throws -> Bool {
        try await gateway.sendCoordsWithoutOrder(lat: lat, lng: lng, heading: Double(heading), speed: speed, online: online)
    }

    public func sendLocationWithOrder(body: SendCoordsBody) async throws -> Bool {
        try await gateway.sendCoordsWithOrder(body: body)
    }
}
