//
//  ExecutorCardWithdrawUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
//

import Foundation

public protocol ExecutorCardWithdrawUseCaseProtocol {
    func execute(cardId: String, amount: Int) async throws -> Bool
}

public final class ExecutorCardWithdrawUseCase: ExecutorCardWithdrawUseCaseProtocol {
    private let gateway: ExecutorCardWithdrawGatewayProtocol
    
    init(gateway: ExecutorCardWithdrawGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = ExecutorCardWithdrawGateway()
    }
    
    public func execute(cardId: String, amount: Int) async throws -> Bool {
        let request = ExecutorCardWithdrawRequest(cardId: cardId, amount: amount)
       
        return try await gateway.withdrawToCard(body: request)
    }
}
