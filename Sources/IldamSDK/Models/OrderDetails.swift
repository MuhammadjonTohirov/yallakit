//
//  OrderDetails.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

import Foundation
import Core

public enum OrderStatus: String, CaseIterable, Codable {
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

public struct OrderDetails: Codable {
    public let id: Int
    public let dateTime: Double?
    public let service: String
    public var status: OrderStatus?
    public let executor: TaxiOrderExecutor?
    public let taxi: OrderTaxiDetails?
    public let comment: String?
    public let statusTime: [StatusTime]?
    public let paymentType: String
    
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
        paymentType: String
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
    }
    
    public struct StatusTime: Codable {
        public let status: OrderStatus
        public let time: Double
        
        init(status: OrderStatus, time: Double) {
            self.status = status
            self.time = time
        }
        
        init(res: NetResOrderDetails.StatusTime) {
            self.status = OrderStatus.init(with: res.status) ?? .sending
            self.time = res.time
        }
    }
}

public struct OrderTaxiDetails: Codable {
    public let tariff: String
    public let startPrice: Float?
    public let distance: Float?
    public let clientTotalPrice: Float
    public let totalPrice: Float?
    public let fixedPrice: Bool
    public let routes: [OrderRoute]
    
    init?(res: NetResOrderDetails?) {
        guard let res = res else { return nil }
        self.tariff = res.taxi?.tariff ?? ""
        self.startPrice = res.taxi?.startPrice
        self.distance = res.taxi?.distance
        self.clientTotalPrice = res.taxi?.clientTotalPrice ?? 0
        self.fixedPrice = res.taxi?.fixedPrice ?? false
        self.totalPrice = res.taxi?.totalPrice
        self.routes = (res.taxi?.routes ?? []).compactMap(OrderRoute.init)
    }
    
    init?(taxiRes res: NetResOrderTaxiDetails?) {
        guard let res else {
            return nil
        }
        
        self.tariff = res.tariff
        self.startPrice = res.startPrice
        self.distance = res.distance
        self.clientTotalPrice = res.clientTotalPrice ?? 0
        self.fixedPrice = res.fixedPrice
        self.totalPrice = res.totalPrice
        self.routes = res.routes.compactMap(OrderRoute.init)
    }
}

public struct TaxiOrderExecutor: Codable {
    public let id: Int
    public let phone: String
    public let givenNames: String
    public let surName: String
    public let fatherName: String?
    public let photo: String
    public let coords: TaxiOrderExecutorCoords?
    public let driver: TaxiOrderExecutorDriver?
    
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
    }
}

public struct TaxiOrderExecutorCoords: Codable {
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

public struct TaxiOrderExecutorDriver: Codable {
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
    
    public struct Color: Codable {
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
