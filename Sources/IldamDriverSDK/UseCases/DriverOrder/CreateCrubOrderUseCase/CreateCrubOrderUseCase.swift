//
//  CreateCrubOrderUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol CreateCrubOrderUseCaseProtocol {
    func create(lat: Double,lng: Double,tariffId: Int,name: String) async throws -> DriverCrubResponse?
}

public final class CreateCrubOrderUseCase: CreateCrubOrderUseCaseProtocol {
    
    private let gateway: CreateCrubOrderGetwayProtocol
    
    init(gateway: CreateCrubOrderGetwayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = CreateCrubOrderGetway()
    }
    
    public func create(lat: Double, lng: Double, tariffId: Int, name: String) async throws -> DriverCrubResponse? {
        
        guard let result = try await gateway.create(lat: lat, lng: lng, tariffId: tariffId, name: name) else {
            throw NSError(domain: "No order found", code: -1)
        }
        
        return DriverCrubResponse(from: result)
    }
}
