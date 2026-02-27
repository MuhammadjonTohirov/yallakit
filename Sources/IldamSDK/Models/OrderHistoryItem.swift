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
    public var id: Int
    public var dateTime: Double?
    public var service: String
    public var status: OrderStatus?
    public var executor: TaxiOrderExecutor?
    public var taxi: OrderTaxiDetails?
    public var comment: String?
    public var statusTime: [OrderDetails.StatusTime]?
    public var paymentType: String
    public var track: [OrderTaxiTrack]?
    public var number: Int64?
    public var options: [OrderDetails.OrderOption]?
    public var intercity: OrderDetails.OrderIntercity?
    public var tariff: OrderDetails.OrderTariff?
    public var routes: [OrderRoute]?
    public var cardId: String?
    
    init?(res: NetResOrderDetails?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.dateTime = res.dateTime
        self.service = res.service
        // I'm not using init with rawValue, some times I do not know why if res.status == at_address then self.status becoming nil. so strange
        self.status = OrderStatus.init(with: res.status)
        self.executor = .init(res: res.executor)
        self.comment = res.comment
        self.taxi = .init(res: res)
        self.statusTime = res.statusTime?.map({OrderDetails.StatusTime(res: $0)})
        self.paymentType = res.paymentType ?? "cash"
        self.track = res.track?.map({OrderTaxiTrack(res: $0)})
        self.number = res.number
        self.options = res.options?.compactMap({.init(res: $0)})
        self.intercity = .init(res: res.intercity)
        self.tariff = .init(res: res.tariff)
        self.routes = res.routes?.compactMap({.init(res: $0)})
        self.cardId = res.cardId
    }
    
    public init(
        id: Int,
        dateTime: Double?,
        service: String,
        status: OrderStatus?,
        executor: TaxiOrderExecutor?,
        taxi: OrderTaxiDetails?,
        comment: String?,
        statusTime: [OrderDetails.StatusTime]?,
        paymentType: String,
        track: [OrderTaxiTrack]?
    ) {
        self.id = id
        self.dateTime = dateTime
        self.service = service
        self.status = status
        self.executor = executor
        self.taxi = taxi
        self.comment = comment
        self.statusTime = statusTime
        self.paymentType = paymentType
        self.track = track
    }
}

extension OrderHistoryItem: Identifiable {
    
}
