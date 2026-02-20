//
//  GetOrderDetailsV2UseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation
import NetworkLayer

public protocol GetOrderDetailsV2UseCaseProtocol: Sendable {
    func execute(orderId: Int) async throws -> OrderDetails?
}

public struct GetOrderDetailsV2UseCase: GetOrderDetailsV2UseCaseProtocol {
    private let gateway: GetOrderDetailsV2GatewayProtocol
    
    init(gateway: GetOrderDetailsV2GatewayProtocol = GetOrderDetailsV2Gateway()) {
        self.gateway = gateway
    }
    
    public init () {
        self.gateway = GetOrderDetailsV2Gateway()
    }
    
    public func execute(orderId: Int) async throws -> OrderDetails? {
        let result = try await gateway.getOrderDetails(orderId: orderId)
        
        return .init(res: result)
    }
}
