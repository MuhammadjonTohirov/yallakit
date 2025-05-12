//
//  OrderAppointedUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 09/05/25.
//

import Foundation

public protocol OrderAppointedUseCaseProtocol {
    func getAppointedOrder(id:Int) async throws -> DriverOrderAppointedResponse
}

public final class OrderAppointedUseCase: OrderAppointedUseCaseProtocol {
    
    private let gateway: GetAppointedOrderGatewayProtocol
    
    init(gateway: GetAppointedOrderGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetAppointedOrderGateway()
    }
    
    public func getAppointedOrder(id: Int) async throws -> DriverOrderAppointedResponse {
        guard let result = try await gateway.getAppointedOrder(orderId: id) else {
            throw NSError(domain: "No Appointed Order found", code: -1)
        }
        
        return DriverOrderAppointedResponse(network: result)
    }
}
