//
//  OrderDetails.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public enum OrderStatus: String, CaseIterable, Codable, Sendable {
    case new
    case sending
    case userSending
    case nonStopSending
    case atAddress
    case inFetters
    case appointed
    case completed
    case canceled
    
    enum CodingKeys: String, CodingKey {
        case new = "new"
        case sending = "sending"
        case userSending = "user_sending"
        case nonStopSending = "nonstop_sending"
        case atAddress = "at_address"
        case inFetters = "in_fetters"
        case appointed = "appointed"
        case completed = "completed"
        case canceled = "canceled"
    }
    
    public init?(with: String) {
        switch with {
        case "new": self = .new
        case "sending": self = .sending
        case "user_sending": self = .userSending
        case "nonstop_sending": self = .nonStopSending
        case "at_address": self = .atAddress
        case "in_fetters": self = .inFetters
        case "appointed": self = .appointed
        case "completed": self = .completed
        case "canceled": self = .canceled
        default: return nil
        }
    }
    
    public var key: String {
        switch self {
        case .new: return "new"
        case .sending: return "sending"
        case .userSending: return "user_sending"
        case .nonStopSending: return "nonstop_sending"
        case .atAddress: return "at_address"
        case .inFetters: return "in_fetters"
        case .appointed: return "appointed"
        case .completed: return "completed"
        case .canceled: return "canceled"
        }
    }
}

public struct OrderDetails: Codable, Sendable {
    public var id: Int
    public var dateTime: Double?
    public var service: String
    public var status: OrderStatus?
    public var executor: TaxiOrderExecutor?
    public var taxi: OrderTaxiDetails?
    public var comment: String?
    public var statusTime: [StatusTime]?
    public var paymentType: String
    public var track: [OrderTaxiTrack]?
    public var number: Int64?
    public var options: [OrderOption]?
    public var intercity: OrderIntercity?
    public var tariff: OrderTariff?
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
        self.statusTime = res.statusTime?.map({StatusTime(res: $0)})
        self.paymentType = res.paymentType ?? "cash"
        self.track = res.track?.map({OrderTaxiTrack(res: $0)})
        self.number = res.number
        self.options = res.options?.compactMap({.init(res: $0)})
        self.intercity = .init(res: res.intercity)
        self.tariff = .init(res: res.tariff)
        self.routes = res.routes?.compactMap({.init(res: $0)})
        self.cardId = res.cardId
        print("new order", res.status)
    }
    
    public init(
        id: Int,
        dateTime: Double?,
        service: String,
        status: OrderStatus?,
        executor: TaxiOrderExecutor?,
        taxi: OrderTaxiDetails?,
        comment: String?,
        statusTime: [StatusTime]?,
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
    
    public struct StatusTime: Codable, Sendable {
        public var status: OrderStatus
        public var time: Double
        
        public init(status: OrderStatus, time: Double) {
            self.status = status
            self.time = time
        }
        
        init(res: NetResOrderDetails.StatusTime) {
            self.status = OrderStatus.init(with: res.status) ?? .sending
            self.time = res.time
        }
    }
}

public extension OrderDetails {
    var isNewOrSending: Bool {
        status?.isNewOrSending ?? true
    }
}

public extension OrderStatus {
    var isNewOrSending: Bool {
        switch self {
        case .new, .sending, .nonStopSending, .userSending:
            return true
        default:
            return false
        }
    }
}

public extension OrderDetails {
    var infoLink: String? {
        var url: String = "https://2gis.ru/geo/"
        
        if let from = taxi?.routes.first?.coords {
            url = url + "\(from.lng),\(from.lat)"
        }
        
        if let to = taxi?.routes.last?.coords {
            url = url + "?m=\(to.lng),\(to.lat)/\(15)"
        }
        
        let distance: String = ((self.taxi?.distance ?? 0) / 1000).description + " km"
        
        let driver: String = self.executor?.fullName ?? "-"
        
        let car: String = [
            self.executor?.driver?.color?.colorName,
            self.executor?.driver?.mark,
            self.executor?.driver?.model
        ].compactMap({$0}).joined(separator: " ")
        
        return "order_info".localize(arguments: url, distance, driver, car)
    }
}

