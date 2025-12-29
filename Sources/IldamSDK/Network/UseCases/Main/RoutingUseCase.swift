//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 23/12/25.
//

import Foundation

public protocol RoutingUseCaseProtocol: Sendable {
    func execute(
        req: [(lat: Double, lng: Double)]
    ) async throws -> RoutingResponse?
}

public struct RoutingUseCase: RoutingUseCaseProtocol {
    public init() {
        
    }
    
    public func execute(req: [(lat: Double, lng: Double)]) async throws -> RoutingResponse? {
        try await RoutingGateway().execute(req: req)
    }
}
