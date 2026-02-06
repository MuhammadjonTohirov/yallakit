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

public struct ArchivedOrdersV2UseCase: ArchivedOrdersV2UseCaseProtocol {
    private let gateway: ArchivedOrdersV2GatewayProtocol
    
    init(gateway: ArchivedOrdersV2GatewayProtocol = ArchivedOrdersV2Gateway()) {
        self.gateway = gateway
    }
    
    public init () {
        self.gateway = ArchivedOrdersV2Gateway()
    }
    
    public func execute(page: Int, limit: Int = 8, brandServiceId: Int? = nil) async -> OrderHistoryResponse? {
        let result = await gateway.loadHistory(page: page, limit: limit, brandServiceId: brandServiceId)
        
        return .init(res: result?.list)
    }
}
