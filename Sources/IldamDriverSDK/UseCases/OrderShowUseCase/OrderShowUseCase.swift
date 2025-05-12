//
//  OrderShowUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 08/05/25.
//

import Foundation

public protocol OrderShowUseCaseProtocol {
    func fetchOrderShow(id:Int) async throws -> OrderShowResponse
}

public final class OrderShowUseCase: OrderShowUseCaseProtocol {
    private let gateway: DriverOrderShowGetwayProtocol
    
    init(gateway: DriverOrderShowGetwayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverOrderShowGateway()
    }
    
    public func fetchOrderShow(id: Int) async throws -> OrderShowResponse {
        guard let response = try await gateway.getDriverOrderShow(orderId: id) else {
            throw NSError(domain: "No order found", code: -1)
        }
        return OrderShowResponse(from: response)
    }
    
    
}
