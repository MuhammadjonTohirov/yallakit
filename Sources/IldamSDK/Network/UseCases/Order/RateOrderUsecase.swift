//
//  RateOrderUsecase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/RateOrderUseCase.swift
import Foundation

public protocol RateOrderUseCaseProtocol {
    func execute(orderId: Int, rate: Int, comment: String) async throws -> Bool
    func execute(orderId: Int, rate: Int, reasons: [Int]) async throws -> Bool
}

public final class RateOrderUseCase: RateOrderUseCaseProtocol {
    private let gateway: RateOrderGatewayProtocol
    
    init(gateway: RateOrderGatewayProtocol = RateOrderGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = RateOrderGateway()
    }
    
    public func execute(orderId: Int, rate: Int, comment: String) async throws -> Bool {
        return try await gateway.rateOrder(
            orderId: orderId,
            rate: rate,
            comment: comment, ratingReasonIds: []
        )
    }
    
    public func execute(orderId: Int, rate: Int, reasons: [Int]) async throws -> Bool {
        return try await gateway.rateOrder(
            orderId: orderId,
            rate: rate,
            comment: "", ratingReasonIds: reasons
        )
    }
}
