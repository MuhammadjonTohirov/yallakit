//
//  OrderTaxiUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 31/12/24.
//

import Foundation
import NetworkLayer
import Core

public protocol OrderTaxiUseCaseProtocol {
    func orderTaxi(req: OrderTaxiRequest) async throws -> Int?
}

public struct OrderTaxiUseCase: OrderTaxiUseCaseProtocol {
    nonisolated(unsafe) public static var shared: OrderTaxiUseCaseProtocol = OrderTaxiUseCase()
    
    public init() {
        
    }
 
    public func orderTaxi(req: OrderTaxiRequest) async throws -> Int? {
        Logging.l(tag: "OrderTaxiUseCase", "order taxi")
        
        let result: NetRes<NetResOrderTaxi>? = try await Network.sendThrow(request: MainNetworkRoute.orderTaxi(
            req: .init(model: req)
        ))
        
        return result?.result?.id
    }
}

public struct OrderTaxiMockUseCase: OrderTaxiUseCaseProtocol {
    public func orderTaxi(req: OrderTaxiRequest) async throws -> Int? {
        Logging.l(tag: "OrderTaxiMockUseCase", "order taxi")
        return 1216985
    }
}
