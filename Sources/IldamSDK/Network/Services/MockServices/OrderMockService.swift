//
//  OrderMockService.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 01/01/25.
//

import Foundation
import CoreLocation
import Core

public final class OrderNetworkMockService: OrderNetworkService {
    private var isOrderCreated: Bool = false
    var createdDate: Date = Date()
    var orderAppointedDate: Date?
    private var previousOrderState: OrderStatus?
    private var orderExecutionCurrentDuration: TimeInterval {
        abs(Date().distance(to: createdDate))
    }
    
    public init() {
        
    }
    
    private var orderState: OrderStatus {
        switch orderExecutionCurrentDuration {
            case ..<15:
            return .new
        case 15...35:
            return .appointed
        case 35..<50:
            return .atAddress
        case 50..<70:
            return .inFetters
        default:
            return .`completed`
        }
    }
    
    private var taxi: NetResTaxiOrderExecutor? {
        if orderState == .new {
            return nil
        }
        
        if orderState == .atAddress || orderState == .completed {
            return .mockWith(coord: (40.383784614558365, 71.78263534351994))
        }
        
        guard let orderAppointedDate else {
            Logging.l(tag: .init("OrderNetworkMockService"), "No appointed date")
            return nil
        }
        
        let waypoints = [
            CLLocationCoordinate2D(latitude: 40.389053921075046, longitude: 71.77663351195669),
            CLLocationCoordinate2D(latitude: 40.385105609058606, longitude: 71.7822304070526),
            CLLocationCoordinate2D(latitude: 40.3843149414556, longitude: 71.78328451519545),
            CLLocationCoordinate2D(latitude: 40.383784614558365, longitude: 71.78263534351994)
        ]
        
        return .mockWith(coord: (0, 0))
    }
    
    private var activeOrderItem: NetResOrderDetails? {
        if orderState == .appointed && previousOrderState != orderState {
            orderAppointedDate = Date()
        }
        
        let orderDetails = NetResOrderDetails.mockWith(
            status: orderState.key,
            orderDate: createdDate,
            detail: .mock,
            taxi: taxi
        )
        
        debugPrint(
            "OrderNetworkMockService",
            "State: \(orderDetails.status), Details: \(orderDetails.executor?.driver?.stateNumber ?? "")"
        )
        
        previousOrderState = orderState
        
        return orderDetails
    }
    
    public override func activeOrders() async throws -> [OrderDetails] {
        Logging.l(tag: "OrderNetworkService", "Load mock orders")
        return isOrderCreated ? [.init(res: activeOrderItem)!] : []
    }
    
    public override func order(withId id: Int) async throws -> OrderDetails? {
        Logging.l(tag: "OrderNetworkService", "Get order with id \(id)")
        return .init(res: activeOrderItem)
    }
    
    public override func activeOrdersCount() async throws -> Int {
        1
    }
    
    public override func cancelOrder(id: Int) async throws -> Bool {
        false
    }
    
    public override func archivedOrder(withId id: Int) async throws -> OrderDetails? {
        nil
    }
    
    public override func orderTaxi(req: OrderTaxiRequest) async throws -> Int? {
        isOrderCreated = true
        Logging.l(tag: "OrderNetworkMockService", "Order new test order")
        return try await OrderTaxiMockUseCase().orderTaxi(req: req)
    }
}
