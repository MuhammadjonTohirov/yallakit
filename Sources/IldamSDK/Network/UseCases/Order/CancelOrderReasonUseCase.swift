//
//  CancelOrderReasonUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/CancelOrderReasonUseCase.swift
import Foundation

public protocol CancelOrderReasonUseCaseProtocol {
    func execute(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool
}

public final class CancelOrderReasonUseCase: CancelOrderReasonUseCaseProtocol {
    private let gateway: CancelOrderReasonGatewayProtocol
    
    init(gateway: CancelOrderReasonGatewayProtocol = CancelOrderReasonGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = CancelOrderReasonGateway()
    }
    
    public func execute(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool {
        return try await gateway.cancelOrderReason(
            orderId: orderId,
            reasonId: reasonId,
            reasonComment: reasonComment
        )
    }
}
