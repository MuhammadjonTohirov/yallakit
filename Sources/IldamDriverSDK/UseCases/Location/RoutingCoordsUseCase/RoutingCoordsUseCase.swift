//
//  RoutingCoordsUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol RoutingCoordsUseCaseProtocol {
    func orderRouting(points: [DNetOrderRoutingPoint]) async throws -> OrderRoutingCoordsResponse?

}

public final class RoutingCoordsUseCase: RoutingCoordsUseCaseProtocol {
    
    private var gateway: OrderRoutingCoordsGatewayProtocol
    
    init(gateway: OrderRoutingCoordsGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderRoutingCoordsGateway()
    }
    
    public func orderRouting(points: [DNetOrderRoutingPoint]) async throws -> OrderRoutingCoordsResponse? {
        
        guard let res = try await gateway.calculateRoute(points: points) else {
            throw NSError(domain: "Order Routing failed", code: -1)
        }
        
        return OrderRoutingCoordsResponse(from: res)
    }
}
