//
//  OrderNetworkService.swift
//  Ildam
//
//  Created by applebro on 17/09/24.
//

// Services/OrderNetworkService.swift
import Foundation
import NetworkLayer
import Core

public protocol OrderNetworkServiceProtocol {
    func activeOrders() async throws -> [OrderDetails]
    
    func order(withId id: Int) async throws -> OrderDetails?
    
    func orderSettings(executor: SettingsConfigUseCase) async throws -> OrderConfigSettings?
    
    func archivedOrder(withId id: Int) async throws -> OrderDetails?
    
    func activeOrdersCount() async throws -> Int
    
    func cancelOrder(id: Int) async throws -> Bool
    
    func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool
    
    func rateOrder(orderId: Int, rate: Int, comment: String) async throws -> Bool
    
    func orderTaxi(req: OrderTaxiRequest) async throws -> Int?
}

public class OrderNetworkService: OrderNetworkServiceProtocol {
    nonisolated(unsafe) public static var shared: OrderNetworkServiceProtocol = OrderNetworkService()
    
    private let activeOrdersUseCase: ActiveOrdersUseCaseProtocol
    private let orderDetailsUseCase: GetOrderDetailsUseCaseProtocol
    private let archivedOrderUseCase: ArchivedOrderUseCaseProtocol
    private let activeOrdersCountUseCase: ActiveOrdersCountUseCaseProtocol
    private let cancelOrderUseCase: CancelOrderUseCaseProtocol
    private let cancelOrderReasonUseCase: CancelOrderReasonUseCaseProtocol
    private let rateOrderUseCase: RateOrderUseCaseProtocol
    var orderTaxiUseCase: OrderTaxiUseCaseProtocol
    
    public init(
        activeOrdersUseCase: ActiveOrdersUseCaseProtocol = ActiveOrdersUseCase(),
        orderDetailsUseCase: GetOrderDetailsUseCaseProtocol = GetOrderDetailsUseCase(),
        archivedOrderUseCase: ArchivedOrderUseCaseProtocol = ArchivedOrderUseCase(),
        activeOrdersCountUseCase: ActiveOrdersCountUseCaseProtocol = ActiveOrdersCountUseCase(),
        cancelOrderUseCase: CancelOrderUseCaseProtocol = CancelOrderUseCase(),
        cancelOrderReasonUseCase: CancelOrderReasonUseCaseProtocol = CancelOrderReasonUseCase(),
        rateOrderUseCase: RateOrderUseCaseProtocol = RateOrderUseCase(),
        orderTaxiUseCase: OrderTaxiUseCaseProtocol = OrderTaxiUseCase()
    ) {
        self.activeOrdersUseCase = activeOrdersUseCase
        self.orderDetailsUseCase = orderDetailsUseCase
        self.archivedOrderUseCase = archivedOrderUseCase
        self.activeOrdersCountUseCase = activeOrdersCountUseCase
        self.cancelOrderUseCase = cancelOrderUseCase
        self.cancelOrderReasonUseCase = cancelOrderReasonUseCase
        self.rateOrderUseCase = rateOrderUseCase
        self.orderTaxiUseCase = orderTaxiUseCase
    }
    
    public func activeOrders() async throws -> [OrderDetails] {
        return try await activeOrdersUseCase.execute()
    }
    
    public func order(withId id: Int) async throws -> OrderDetails? {
        return try await orderDetailsUseCase.execute(orderId: id)
    }
    
    public func orderSettings(executor: SettingsConfigUseCase = SettingsConfigUseCaseImpl()) async throws -> OrderConfigSettings? {
        try await executor.fetch()
    }
    
    public func archivedOrder(withId id: Int) async throws -> OrderDetails? {
        return try await archivedOrderUseCase.execute(id: id)
    }
    
    public func activeOrdersCount() async throws -> Int {
        return try await activeOrdersCountUseCase.execute()
    }
    
    public func cancelOrder(id: Int) async throws -> Bool {
        return try await cancelOrderUseCase.execute(id: id)
    }
    
    public func cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String) async throws -> Bool {
        return try await cancelOrderReasonUseCase.execute(
            orderId: orderId,
            reasonId: reasonId,
            reasonComment: reasonComment
        )
    }
    
    public func rateOrder(orderId: Int, rate: Int, comment: String) async throws -> Bool {
        return try await rateOrderUseCase.execute(
            orderId: orderId,
            rate: rate,
            comment: comment
        )
    }
    
    public func orderTaxi(req: OrderTaxiRequest) async throws -> Int? {
        try await orderTaxiUseCase.orderTaxi(req: req)
    }
}
