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
    
    init?(res: [NetResOrderHistoryItem]?) {
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
    public let taxi: OrderTaxiDetails?
    public let comment: String?
    public let services: [OrderHistoryService]?
    
    public struct Coord {
        public let lat, lng: Double
    }
    
    public init(id: Int, dateTime: Double, service: String, status: String, track: [Coord]?, executor: TaxiOrderExecutor?, taxi: OrderTaxiDetails?, comment: String?, services: [OrderHistoryService]?) {
        self.id = id
        self.dateTime = dateTime
        self.service = service
        self.status = status
        self.track = track
        self.executor = executor
        self.taxi = taxi
        self.comment = comment
        self.services = services
    }
    
    init?(res: NetResOrderHistoryItem?) {
        guard let res else { return nil }
        
        self.id = res.id
        self.dateTime = res.dateTime
        self.service = res.service
        self.status = res.status
        self.track = res.track?.map { Coord(lat: $0.lat, lng: $0.lng) }
        self.executor = .init(res: res.executor)
        self.taxi = .init(taxiRes: res.taxi)
        self.comment = res.comment
        self.services = res.services?.compactMap({.init(res: $0)})
    }
}

public struct OrderHistoryService {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(res: NetResOrderHistoryService?) {
        guard let res else { return nil }
        
        self.id = res.id
        self.name = res.name
    }
}

extension OrderHistoryItem: Identifiable {
    
}
