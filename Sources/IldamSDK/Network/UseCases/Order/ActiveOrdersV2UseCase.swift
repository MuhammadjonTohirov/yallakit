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

public struct ActiveOrdersV2UseCase: ActiveOrdersV2UseCaseProtocol, Sendable {
    private let gateway: ActiveOrdersV2GatewayProtocol

    public init() {
        self.gateway = ActiveOrdersV2Gateway()
    }

    init(gateway: ActiveOrdersV2GatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> [OrderDetails]? {
        let list = try await gateway.getActiveOrders()
        
        return list?.compactMap({.init(res: $0)})
    }
}
