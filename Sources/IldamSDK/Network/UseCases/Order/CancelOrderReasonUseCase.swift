//
//  CancelOrderReasonUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/CancelOrderReasonUseCase.swift
import Foundation

public protocol CancelOrderReasonUseCaseProtocol: Sendable {
    func execute(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool
}

public struct CancelOrderReasonUseCase: CancelOrderReasonUseCaseProtocol, Sendable {
    private let gateway: CancelOrderReasonGatewayProtocol

    public init() {
        self.gateway = CancelOrderReasonGateway()
    }

    init(gateway: CancelOrderReasonGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool {
        return try await gateway.cancelOrderReason(
            orderId: orderId,
            reasonId: reasonId,
            reasonComment: reasonComment
        )
    }
}
