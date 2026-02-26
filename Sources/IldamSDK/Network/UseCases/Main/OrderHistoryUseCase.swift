//
//  OrderHistoryUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/LoadOrderHistoryUseCase.swift
import Foundation

public protocol LoadOrderHistoryUseCaseProtocol: Sendable {
    func execute(page: Int, limit: Int) async -> OrderHistoryResponse?
}

public struct LoadOrderHistoryUseCase: LoadOrderHistoryUseCaseProtocol, Sendable {
    private let gateway: OrderHistoryGatewayProtocol

    public init() {
        self.gateway = OrderHistoryGateway()
    }

    init(gateway: OrderHistoryGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(page: Int, limit: Int = 8) async -> OrderHistoryResponse? {
        guard let result = await gateway.loadHistory(page: page, limit: limit) else {
            return nil
        }
        
        return OrderHistoryResponse(res: result.list)
    }
}
