//
//  RateOrderUsecase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/RateOrderUseCase.swift
import Foundation

public protocol RateOrderV2UseCaseProtocol {
    func execute(orderId: Int, rate: Int, comment: String) async throws -> Bool
    func execute(orderId: Int, rate: Int, reasons: [Int]) async throws -> Bool
}

public final class RateOrderV2UseCase: RateOrderV2UseCaseProtocol {
    private let gateway: RateOrderV2GatewayProtocol
    
    init(gateway: RateOrderV2GatewayProtocol = RateOrderV2Gateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = RateOrderV2Gateway()
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
