//
//  FasterOrderUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 03/04/25.
//

import Foundation

public protocol FasterOrderUseCaseProtocol {
    func execute(orderId: Int) async -> Bool
}

public struct FasterOrderUseCase: FasterOrderUseCaseProtocol {
    public init() {}
    
    public func execute(orderId: Int) async -> Bool {
        await FastOrderGatewayImpl().getFasterOrder(orderId: orderId)
    }
}
