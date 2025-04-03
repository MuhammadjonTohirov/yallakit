//
//  OrderHistoryUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/LoadOrderHistoryUseCase.swift
import Foundation

public protocol LoadOrderHistoryUseCaseProtocol {
    func execute(page: Int, limit: Int) async -> OrderHistoryResponse?
}

public final class LoadOrderHistoryUseCase: LoadOrderHistoryUseCaseProtocol {
    private let gateway: OrderHistoryGatewayProtocol
    
    init(gateway: OrderHistoryGatewayProtocol = OrderHistoryGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = OrderHistoryGateway()
    }
    
    public func execute(page: Int, limit: Int = 8) async -> OrderHistoryResponse? {
        guard let result = await gateway.loadHistory(page: page, limit: limit) else {
            return nil
        }
        
        return OrderHistoryResponse(res: result.list)
    }
}
