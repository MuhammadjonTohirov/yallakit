//
//  Driverd.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

protocol DriverSendCoordUseCaseProtocol {
    func sendLocationWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double) async throws -> Bool
    func sendLocationWithOrder(body: SendCoordsBody) async throws -> Bool
}

final class DriverSendCoordUseCase: DriverSendCoordUseCaseProtocol {
    
    private let gateway: DriverSendCoordProtocol
    
    init(gateway: DriverSendCoordProtocol = DriverSendCoordGateway()) {
        self.gateway = gateway
    }

    func sendLocationWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double) async throws -> Bool {
        try await gateway.sendCoordsWithoutOrder(lat: lat, lng: lng, heading: Double(heading), speed: speed)
    }

    func sendLocationWithOrder(body: SendCoordsBody) async throws -> Bool {
        try await gateway.sendCoordsWithOrder(body: body)
    }
}
