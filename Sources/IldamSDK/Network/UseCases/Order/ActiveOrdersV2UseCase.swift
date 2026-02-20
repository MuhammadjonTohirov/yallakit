//
//  ActiveOrdersV2UseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation
import NetworkLayer

public protocol ActiveOrdersV2UseCaseProtocol: Sendable {
    func execute() async throws -> [OrderDetails]?
}

public struct ActiveOrdersV2UseCase: ActiveOrdersV2UseCaseProtocol {
    private let gateway: ActiveOrdersGatewayProtocol
    
    init(gateway: ActiveOrdersGatewayProtocol = ActiveOrdersV2Gateway()) {
        self.gateway = gateway
    }
    
    public init () {
        self.gateway = ActiveOrdersV2Gateway()
    }
    
    public func execute() async throws -> [OrderDetails]? {
        let list = try await gateway.getActiveOrders()
        
        return list?.compactMap({.init(res: $0)})
    }
}
