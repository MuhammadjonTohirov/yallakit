//
//  ArchivedOrderV2UseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation
import NetworkLayer

public protocol ArchivedOrderV2UseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> OrderDetails?
}

public struct ArchivedOrderV2UseCase: ArchivedOrderV2UseCaseProtocol {
    private let gateway: ArchivedOrderV2GatewayProtocol
    
    init(gateway: ArchivedOrderV2GatewayProtocol = ArchivedOrderV2Gateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ArchivedOrderV2Gateway()
    }
    
    public func execute(id: Int) async throws -> OrderDetails? {
        let result = try await gateway.getArchivedOrder(id: id)
        
        return .init(res: result)
    }
}
