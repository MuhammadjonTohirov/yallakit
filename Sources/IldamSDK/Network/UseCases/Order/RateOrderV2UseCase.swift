//
//  RateOrderUsecase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/RateOrderUseCase.swift
import Foundation

public protocol RateOrderV2UseCaseProtocol: Sendable {
    func execute(orderId: Int, rate: Int, comment: String) async throws -> Bool
    func execute(orderId: Int, rate: Int, reasons: [Int]) async throws -> Bool
}

public struct RateOrderV2UseCase: RateOrderV2UseCaseProtocol, Sendable {
    private let gateway: RateOrderV2GatewayProtocol

    public init() {
        self.gateway = RateOrderV2Gateway()
    }

    init(gateway: RateOrderV2GatewayProtocol) {
        self.gateway = gateway
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
