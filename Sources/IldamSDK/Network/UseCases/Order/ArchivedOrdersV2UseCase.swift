//
//  ArchivedOrdersV2UseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation
import NetworkLayer

public protocol ArchivedOrdersV2UseCaseProtocol: Sendable {
    func execute(page: Int, limit: Int, brandServiceId: Int?) async -> OrderHistoryResponse?
}

public struct ArchivedOrdersV2UseCase: ArchivedOrdersV2UseCaseProtocol, Sendable {
    private let gateway: ArchivedOrdersV2GatewayProtocol

    public init() {
        self.gateway = ArchivedOrdersV2Gateway()
    }

    init(gateway: ArchivedOrdersV2GatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(page: Int, limit: Int = 8, brandServiceId: Int? = nil) async -> OrderHistoryResponse? {
        let result = await gateway.loadHistory(page: page, limit: limit, brandServiceId: brandServiceId)
        
        return .init(res: result?.list)
    }
}
