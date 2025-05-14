//
//  OrderListUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol OrderListUseCaseProtocol {
    func fetchOrderList(type: String) async throws -> OrderListResponse
}

public final class OrderListUseCase: OrderListUseCaseProtocol {
    private let gateway: EtherListGetwayProtocol
    
    init(gateway: EtherListGetwayProtocol) {
        self.gateway = gateway
    }
    
    public init () {
        self.gateway = EtherListGateway()
    }
    public func fetchOrderList(type: String) async throws -> OrderListResponse {
        guard let result = try await gateway.getEtherList(type: type) else {
            throw NSError(domain: "No configuration found", code: -1)
        }
        return OrderListResponse(from: result)
    }
    
    
}
