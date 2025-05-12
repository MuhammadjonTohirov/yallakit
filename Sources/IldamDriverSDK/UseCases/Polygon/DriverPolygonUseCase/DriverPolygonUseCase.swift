//
//  DriverPolygonUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol DriverPolygonUseCaseProtocol {
    func fetchPolygon(by id: Int) async throws -> DriverPolygonResponse
}

public final class DriverPolygonUseCaseImpl: DriverPolygonUseCaseProtocol {
    
    private let gateway: DriverPolygonGatewayProtocol
    
    init(gateway: DriverPolygonGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverPolygonGateway()
    }
    
    public func fetchPolygon(by id: Int) async throws -> DriverPolygonResponse {
        
        guard let result = try? await gateway.fetchPolygon(by: id) else {
            throw NSError(domain: "No fetchPolygon found", code: -1)
        }
        return DriverPolygonResponse(from: result)
    }
}
