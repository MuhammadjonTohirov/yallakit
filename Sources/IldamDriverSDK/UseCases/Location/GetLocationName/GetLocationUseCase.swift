//
//  GetLocationUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol GetLocationUseCaseProtocol {
    func getLocationName(lat: Double, lng: Double) async throws -> LocationNameResponse
}

public struct GetLocationUseCase: GetLocationUseCaseProtocol {
    
    private var gateway: GetLocationNameGatewayProtocol
    
    init(gateway: GetLocationNameGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetLocationNameGateway()
    }
    public func getLocationName(lat: Double, lng: Double) async throws -> LocationNameResponse {
        
        guard let res = try? await gateway.fetchLocationName(lat: lat, lng: lng) else {
            throw NSError(domain: "Get LocationName failed", code: -1)
        }
        return LocationNameResponse(from: res)
    }
}
