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

public struct OrderTaxiDetails: Codable, Sendable {
    public var tariff: String
    public var startPrice: Float?
    public var distance: Float?
    public var clientTotalPrice: Float
    public var totalPrice: Float?
    public var fixedPrice: Bool
    public var isUsingBonus: Bool?
    public var bonusAmount: Double?
    public var routes: [OrderRoute]
    public var services: [OrderServiceItem]?
    public var award: Award?
    public var waitingTime: Float?
    public var waitingCost: Float?

    public init(tariff: String, startPrice: Float?, distance: Float?, clientTotalPrice: Float, totalPrice: Float?, fixedPrice: Bool, isUsingBonus: Bool? = nil, bonusAmount: Double? = nil, routes: [OrderRoute], services: [OrderServiceItem]? = nil, award: Award? = nil, waitingTime: Float? = nil, waitingCost: Float? = nil) {
        self.tariff = tariff
        self.startPrice = startPrice
        self.distance = distance
        self.clientTotalPrice = clientTotalPrice
        self.totalPrice = totalPrice
        self.fixedPrice = fixedPrice
        self.isUsingBonus = isUsingBonus
        self.bonusAmount = bonusAmount
        self.routes = routes
        self.services = services
        self.award = award
        self.waitingTime = waitingTime
        self.waitingCost = waitingCost
    }
    
    init?(res: NetResOrderDetails?) {
        guard let res = res else { return nil }
        self.tariff = res.taxi?.tariff ?? ""
        self.startPrice = res.taxi?.startPrice
        self.distance = res.taxi?.distance
        self.clientTotalPrice = res.taxi?.clientTotalPrice ?? 0
        self.fixedPrice = res.taxi?.fixedPrice ?? false
        self.totalPrice = res.taxi?.totalPrice
        self.routes = (res.taxi?.routes ?? []).compactMap(OrderRoute.init)
        self.services = res.taxi?.services?.compactMap(OrderServiceItem.init)
        self.bonusAmount = res.taxi?.bonusAmount
        self.isUsingBonus = res.taxi?.bonusAmount != nil
        self.award = res.taxi?.award.map { Award(amount: $0.amount, type: $0.type) }
        self.waitingCost = res.taxi?.waitingCost
        if let waitingTime = res.taxi?.waitingTime, waitingTime > 0 {
            self.waitingTime = waitingTime
        } else {
            self.waitingTime = nil
        }
    }
    
    init?(taxiRes res: NetResOrderTaxiDetails?) {
        guard let res else {
            return nil
        }
        
        self.tariff = res.tariff ?? ""
        self.startPrice = res.startPrice
        self.distance = res.distance
        self.clientTotalPrice = res.clientTotalPrice ?? 0
        self.fixedPrice = res.fixedPrice ?? false
        self.totalPrice = res.totalPrice
        self.routes = res.routes?.compactMap(OrderRoute.init) ?? []
        self.bonusAmount = res.bonusAmount
        self.isUsingBonus = res.bonusUsed
        self.award = res.award.map { Award(amount: $0.amount, type: $0.type) }
        self.waitingTime = res.waitingTime
        self.waitingCost = res.waitingCost
    }
    
    
    public struct Award: Codable, Sendable {
        public var amount: Int
        public var type: String
        
        public init(amount: Int, type: String) {
            self.amount = amount
            self.type = type
        }
    }
}

public struct TaxiOrderExecutor: Codable, Sendable {
    public var id: Int
    public var phone: String
    public var givenNames: String
    public var surName: String
    public var fatherName: String?
    public var photo: String
    public var coords: TaxiOrderExecutorCoords?
    public var rating: Int?
    public var driver: TaxiOrderExecutorDriver?
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.phone = res.phone
        self.givenNames = res.givenNames ?? ""
        self.surName = res.surName ?? ""
        self.fatherName = res.fatherName
        self.photo = res.photo ?? ""
        self.coords = TaxiOrderExecutorCoords(res: res)
        self.driver = TaxiOrderExecutorDriver(res: res)
        self.rating = res.rating
    }
    
    public init(id: Int, phone: String, givenNames: String, surName: String, fatherName: String?, rating: Int? = 2, photo: String, coords: TaxiOrderExecutorCoords?, driver: TaxiOrderExecutorDriver?) {
        self.id = id
        self.phone = phone
        self.givenNames = givenNames
        self.surName = surName
        self.fatherName = fatherName
        self.photo = photo
        self.coords = coords
        self.driver = driver
        self.rating = rating
    }
}

public struct TaxiOrderExecutorCoords: Codable, Sendable {
    public let lat: Double
    public let lng: Double
    public let heading: Double?
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.lat = res.coords?.lat ?? 0
        self.lng = res.coords?.lng ?? 0
        self.heading = res.coords?.heading
    }
    
    public init(lat: Double, lng: Double, heading: Double = 0) {
        self.lat = lat
        self.lng = lng
        self.heading = heading
    }
}

public struct TaxiOrderExecutorDriver: Codable, Sendable {
    public let id: Int
    public let color: TaxiOrderExecutorDriver.Color?
    public let stateNumber: String?
    public let mark: String?
    public let model: String?
    
    public init(id: Int, color: Color? = nil, stateNumber: String? = nil, mark: String? = nil, model: String? = nil) {
        self.id = id
        self.color = color
        self.stateNumber = stateNumber
        self.mark = mark
        self.model = model
    }
    
    init?(res: NetResTaxiOrderExecutor?) {
        guard let res = res else { return nil }
        self.id = res.id
        self.color = .init(res: res.driver?.color)
        self.stateNumber = res.driver?.stateNumber
        self.mark = res.driver?.mark
        self.model = res.driver?.model
    }
    
    public struct Color: Codable, Sendable {
        public let color: String?
        public let colorName: String?
        
        public init(color: String?, colorName: String?) {
            self.color = color
            self.colorName = colorName
        }
        
        init?(res: NetResTaxiOrderExecutorDriver.Color?) {
            guard let res = res else { return nil }
            self.color = res.color
            self.colorName = res.colorName
        }
    }
}

public extension TaxiOrderExecutor {
    var fullName: String {
        return [givenNames.nilIfEmpty, surName.nilIfEmpty, fatherName?.nilIfEmpty].compactMap({ $0 }).joined(separator: " ")
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

public struct OrderServiceItem: Codable, Sendable {
    public var cost: Double?
    public var costType: String?
    public var name: String?
    
    public init(cost: Double? = nil, costType: String? = nil, name: String? = nil) {
        self.cost = cost
        self.costType = costType
        self.name = name
    }
    
    init(_ res: NetResOrderService) {
        self.cost = res.cost
        self.costType = res.costType
        self.name = res.name
    }
}

public struct OrderTaxiTrack: Codable, Sendable {
    public var accuracy: Double?
    public var lat: Double?
    public var lng: Double?
    public var locationType: String? // ex: fused
    public var online: Bool?
    public var speed: Double?
    public var status: String? // ex: appointed
    public var time: Int64?
    
    init(res: NetResOrderTaxiTrack) {
        self.accuracy = res.accuracy
        self.lat = res.lat
        self.lng = res.lng
        self.locationType = res.locationType
        self.online = res.online
        self.speed = res.speed
        self.status = res.status
        self.time = res.time
    }
    
    public init(accuracy: Double? = nil, lat: Double? = nil, lng: Double? = nil, locationType: String? = nil, online: Bool? = nil, speed: Double? = nil, status: String? = nil, time: Int64? = nil) {
        self.accuracy = accuracy
        self.lat = lat
        self.lng = lng
        self.locationType = locationType
        self.online = online
        self.speed = speed
        self.status = status
        self.time = time
    }
}
