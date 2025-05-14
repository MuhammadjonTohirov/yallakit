//
//  ExecutorOrderHistoryUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol DriverOrderHistoryUseCaseProtocol {
    func fetchStatisticsHistory(perPage:Int,date:String,type:String,page: Int) async throws -> ExecutorOrderHistoryResponse
}

public final class DriverOrderHistoryUseCase: DriverOrderHistoryUseCaseProtocol {
    
    private var gateway:ExecutorOrderHistoryGatewayProtocol
    
    init(gateway: ExecutorOrderHistoryGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorOrderHistoryGateway()
    }
    
    public func fetchStatisticsHistory(perPage: Int, date: String, type: String, page: Int) async throws -> ExecutorOrderHistoryResponse {
        
    let result = try await gateway.fetchOrderHistory(perPage: perPage, date: date, type: type, page: page)
    
        return ExecutorOrderHistoryResponse(from: result)
    }
}
