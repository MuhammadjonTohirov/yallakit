//
//  TransportList.swift
//  YallaKit
//
//  Created by MuhammadAli on 16/05/25.
//

import NetworkLayer
import Foundation

public protocol DriverTransportMarkModelsUseCaseProtocol {
    func execute() async throws -> [TransportMarkModelResponse]
}

public final class DriverTransportMarkModelsUseCase: DriverTransportMarkModelsUseCaseProtocol {
    
    private let gateway: DriverTransportMarkModelsProtocol

    init(gateway: DriverTransportMarkModelsProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverTransportMarkModelsGateway()
    }
    public func execute() async throws -> [TransportMarkModelResponse] {
        guard let result = try await gateway.fetchCarList() else {
            throw NSError(domain: "No transport mark models found", code: -1)
        }
        
        return result.map { TransportMarkModelResponse(from: $0) }
    }
}

