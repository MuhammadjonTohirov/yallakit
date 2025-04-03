//
//  GetorderDetailsUsecase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 26/03/25.
//

// UseCases/GetOrderDetailsUseCase.swift
import Foundation
import Core

public protocol GetOrderDetailsUseCaseProtocol {
    func execute(orderId: Int) async throws -> OrderDetails?
}

public final class GetOrderDetailsUseCase: GetOrderDetailsUseCaseProtocol {
    private let gateway: GetOrderDetailsGatewayProtocol
    
    init(gateway: GetOrderDetailsGatewayProtocol = GetOrderDetailsGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetOrderDetailsGateway()
    }
    
    public func execute(orderId: Int) async throws -> OrderDetails? {
        let result = try await gateway.getOrderDetails(orderId: orderId)
        return OrderDetails(res: result)
    }
}
