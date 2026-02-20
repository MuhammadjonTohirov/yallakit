//
//  OrderHistoryItem.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

import Foundation
import Core

public struct OrderHistoryResponse {
    public let list: [OrderHistoryItem]
    
    public init(list: [OrderHistoryItem]) {
        self.list = list
    }
    
    init?(res: [NetResOrderDetails]?) {
        guard let res else { return nil }
        
        self.list = res.compactMap(OrderHistoryItem.init)
    }
}

public struct OrderHistoryItem {
    public let id: Int
    public let dateTime: Double
    public let service, status: String
    public let track: [Coord]?
    public let executor: TaxiOrderExecutor?
    public var taxi: OrderTaxiDetails?
    public let comment: String?
    public var intercity: OrderDetails.OrderIntercity?
    public var routes: [OrderRoute]?

    public struct Coord {
        public let lat, lng: Double
    }
    
    public init(id: Int, dateTime: Double, service: String, status: String, track: [Coord]?, executor: TaxiOrderExecutor?, taxi: OrderTaxiDetails?, comment: String?) {
        self.id = id
        self.dateTime = dateTime
        self.service = service
        self.status = status
        self.track = track
        self.executor = executor
        self.taxi = taxi
        self.comment = comment
    }
    
    init?(res: NetResOrderDetails?) {
        guard let res else { return nil }
        
        self.id = res.id
        self.dateTime = res.dateTime ?? 0
        self.service = res.service
        self.status = res.status
        self.track = res.track?.map { Coord(lat: $0.lat ?? 0, lng: $0.lng ?? 0) }
        self.executor = .init(res: res.executor)
        self.taxi = .init(taxiRes: res.taxi)
        self.comment = res.comment
        self.routes = res.routes?.compactMap({.init(res: $0)})
        self.intercity = .init(res: res.intercity)
        self.taxi?.routes = self.routes ?? []
    }
}

extension OrderHistoryItem: Identifiable {
    
}
