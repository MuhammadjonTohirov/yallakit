//
//  DriverStatisticsUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol DriverStatisticsUseCaseProtocol {
    func fetchStatistics(type: String) async throws -> DriverStatisticsResponse
}

public final class DriverStatisticsUseCase: DriverStatisticsUseCaseProtocol {
    private var gateway: DriverStatisticsGatewayProtocol
    
    init(gateway: DriverStatisticsGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverStatisticsGateway()
    }
    
    public func fetchStatistics(type: String) async throws -> DriverStatisticsResponse {
        
        guard let result = try await gateway.fetchStatistics(type: type) else {
            throw NSError(domain: "No fetch Statistics Tariffs", code: -1)
        }
        
        return DriverStatisticsResponse(from: result)
    }
}
