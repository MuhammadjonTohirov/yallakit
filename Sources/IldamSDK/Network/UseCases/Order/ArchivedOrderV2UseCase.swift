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

public struct ArchivedOrderV2UseCase: ArchivedOrderV2UseCaseProtocol, Sendable {
    private let gateway: ArchivedOrderV2GatewayProtocol

    public init() {
        self.gateway = ArchivedOrderV2Gateway()
    }

    init(gateway: ArchivedOrderV2GatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(id: Int) async throws -> OrderDetails? {
        let result = try await gateway.getArchivedOrder(id: id)
        
        return .init(res: result)
    }
}
