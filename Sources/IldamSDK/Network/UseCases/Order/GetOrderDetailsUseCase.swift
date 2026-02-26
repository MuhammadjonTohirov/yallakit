//
//  GetorderDetailsUsecase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/GetOrderDetailsUseCase.swift
import Foundation
import Core

public protocol GetOrderDetailsUseCaseProtocol: Sendable {
    func execute(orderId: Int) async throws -> OrderDetails?
}

public struct GetOrderDetailsUseCase: GetOrderDetailsUseCaseProtocol, Sendable {
    private let gateway: GetOrderDetailsGatewayProtocol

    public init() {
        self.gateway = GetOrderDetailsGateway()
    }

    init(gateway: GetOrderDetailsGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(orderId: Int) async throws -> OrderDetails? {
        let result = try await gateway.getOrderDetails(orderId: orderId)
        return OrderDetails(res: result)
    }
}
