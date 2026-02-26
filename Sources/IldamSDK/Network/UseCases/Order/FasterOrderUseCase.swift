//
//  FasterOrderUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 03/04/25.
//

import Foundation

public protocol FasterOrderUseCaseProtocol: Sendable {
    func execute(orderId: Int) async -> Bool
}

public struct FasterOrderUseCase: FasterOrderUseCaseProtocol, Sendable {
    private let gateway: FasterOrderGateway

    public init() {
        self.gateway = FastOrderGatewayImpl()
    }

    init(gateway: FasterOrderGateway) {
        self.gateway = gateway
    }

    public func execute(orderId: Int) async -> Bool {
        await gateway.getFasterOrder(orderId: orderId)
    }
}
