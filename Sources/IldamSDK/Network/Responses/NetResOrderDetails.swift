//
//  NetResOrderDetails.swift
//  Ildam
//
//  Created by applebro on 27/01/24.
//

import Foundation

struct NetResActiveOrders: NetResBody {
    var list: [NetResOrderDetails]?
}

struct NetResOrderDetails: NetResBody {
    var id: Int
    var dateTime: Double?
    var service: String
    var status: String
    var statusTime: [StatusTime]?
    var executor: NetResTaxiOrderExecutor?
    var taxi: NetResOrderTaxiDetails?
    var track: [NetResOrderTaxiTrack]?
    var comment: String?
    var paymentType: String?
    var number: Int64?
    var options: [NetResOrderOption]?
    var intercity: NetResOrderIntercity?
    var tariff: NetResOrderTariff?
    var routes: [NetResOrderRoute]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateTime = "date_time"
        case service
        case status
        case executor
        case taxi
        case comment
        case statusTime = "status_time"
        case paymentType = "payment_type"
        case track
        case number
        case options
        case intercity
        case tariff
        case routes
    }
    
    init(id: Int, dateTime: Double?, service: String, status: String, executor: NetResTaxiOrderExecutor?, taxi: NetResOrderTaxiDetails?, comment: String?) {
        self.id = id
        self.dateTime = dateTime
        self.service = service
        self.status = status
        self.executor = executor
        self.taxi = taxi
        self.comment = comment
        self.statusTime = []
        self.paymentType = "cash"
        self.number = nil
        self.options = nil
        self.intercity = nil
        self.tariff = nil
        self.routes = nil
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.dateTime, forKey: .dateTime)
        try container.encode(self.service, forKey: .service)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.executor, forKey: .executor)
        try container.encodeIfPresent(self.taxi, forKey: .taxi)
        try container.encodeIfPresent(self.comment, forKey: .comment)
        try container.encodeIfPresent(self.statusTime, forKey: .statusTime)
        try container.encodeIfPresent(self.paymentType, forKey: .paymentType)
        try container.encodeIfPresent(self.track, forKey: .track)
        try container.encodeIfPresent(self.number, forKey: .number)
        try container.encodeIfPresent(self.options, forKey: .options)
        try container.encodeIfPresent(self.intercity, forKey: .intercity)
        try container.encodeIfPresent(self.tariff, forKey: .tariff)
        try container.encodeIfPresent(self.routes, forKey: .routes)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.dateTime = try container.decodeIfPresent(Double.self, forKey: .dateTime)
        self.service = try container.decode(String.self, forKey: .service)
        self.status = try container.decode(String.self, forKey: .status)
        self.executor = try container.decodeIfPresent(NetResTaxiOrderExecutor.self, forKey: .executor)
        self.taxi = try container.decodeIfPresent(NetResOrderTaxiDetails.self, forKey: .taxi)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
        self.statusTime = try container.decodeIfPresent([StatusTime].self, forKey: .statusTime)
        self.paymentType = try? container.decodeIfPresent(String.self, forKey: .paymentType)
        self.track = try? container.decodeIfPresent([NetResOrderTaxiTrack].self, forKey: .track)
        self.number = try? container.decodeIfPresent(Int64.self, forKey: .number)
        self.options = try? container.decodeIfPresent([NetResOrderOption].self, forKey: .options)
        self.intercity = try? container.decodeIfPresent(NetResOrderIntercity.self, forKey: .intercity)
        self.tariff = try? container.decodeIfPresent(NetResOrderTariff.self, forKey: .tariff)
        self.routes = try? container.decodeIfPresent([NetResOrderRoute].self, forKey: .routes)
    }
    
    struct StatusTime: Codable {
        var status: String
        var time: Double
    }
}

struct NetResOrderTaxiDetails: Codable {
    let tariff: String?
    let startPrice: Float?
    let distance: Float?
    let clientTotalPrice: Float?
    let totalPrice: Float?
    let fixedPrice: Bool?
    let routes: [NetResOrderRoute]?
    let services: [NetResOrderService]?
    let bonusUsed: Bool?
    var bonusAmount: Double?
    var award: Award?
    var waitingTime: Float?
    var waitingCost: Float?
    var duration: Float?
    
    enum CodingKeys: String, CodingKey {
        case tariff
        case startPrice = "start_price"
        case distance
        case clientTotalPrice = "client_total_price"
        case fixedPrice = "fixed_price"
        case totalPrice = "total_price"
        case routes
        case bonusUsed = "use_the_bonus"
        case bonusAmount = "bonus_amount"
        case services
        case award
        case waitingTime = "waiting_time"
        case waitingCost = "waiting_cost"
        case duration
    }
    
    struct Award: Codable {
        var amount: Int
        var type: String
        
        enum CodingKeys: String, CodingKey {
            case amount = "payment_award"
            case type = "payment_type"
        }
    }
}

struct NetResTaxiOrderExecutor: Codable {
    let id: Int
    let phone: String
    let givenNames: String?
    let surName: String?
    let fatherName: String?
    let photo: String?
    let rating: Int?
    var coords: NetResTaxiOrderExecutorCoords?
    let driver: NetResTaxiOrderExecutorDriver?
    
    enum CodingKeys: String, CodingKey {
        case id
        case phone
        case givenNames = "given_names"
        case surName = "sur_name"
        case photo
        case fatherName = "father_name"
        case coords
        case driver
        case rating = "rating"
    }
}

struct NetResTaxiOrderExecutorCoords: Codable {
    let lat: Double
    let lng: Double
    let heading: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
        case heading
    }
    
    init(lat: Double, lng: Double, heading: Double = 0) {
        self.lat = lat
        self.lng = lng
        self.heading = heading
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.heading = try container.decodeIfPresent(Double.self, forKey: .heading)
        
        let _lat = (try? container.decode(Double.self, forKey: .lat)) ?? Double((try? container.decode(String.self, forKey: .lat)) ?? "0")
        let _lng = (try? container.decode(Double.self, forKey: .lng)) ?? Double((try? container.decode(String.self, forKey: .lng)) ?? "0")
        
        self.lat = _lat ?? 0
        self.lng = _lng ?? 0
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lng, forKey: .lng)
        try container.encodeIfPresent(self.heading, forKey: .heading)
    }
}

struct NetResTaxiOrderExecutorDriver: Codable {
    let id: Int
    let color: NetResTaxiOrderExecutorDriver.Color?
    let stateNumber: String?
    let mark: String?
    let model: String?
    let callsign: String?
    
    init(id: Int, color: NetResTaxiOrderExecutorDriver.Color?, stateNumber: String?, mark: String?, model: String?, callsign: String? = nil) {
        self.id = id
        self.color = color
        self.stateNumber = stateNumber
        self.mark = mark
        self.model = model
        self.callsign = callsign
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case stateNumber = "state_number"
        case mark = "mark"
        case model = "model"
        case callsign
    }
    
    struct Color: Codable {
        let id: Int?
        let color: String?
        let colorName: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case color
            case colorName = "name"
        }
    }
}

extension NetResOrderDetails {
    var asModel: OrderDetails? {
        .init(res: self)
    }
}

struct NetResOrderService: Codable {
    let cost: Double?
    let costType: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case cost
        case costType = "cost_type"
        case name
    }
}

struct NetResOrderTaxiTrack: Codable {
    var accuracy: Double?
    var lat: Double?
    var lng: Double?
    var locationType: String? // ex: fused
    var online: Bool?
    var speed: Double?
    var status: String? // ex: appointed
    var time: Int64?
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case lat
        case lng
        case locationType = "location_type"
        case online
        case speed
        case status
        case time
    }
    
    init(accuracy: Double? = nil, lat: Double? = nil, lng: Double? = nil, locationType: String? = nil, online: Bool? = nil, speed: Double? = nil, status: String? = nil, time: Int64? = nil) {
        self.accuracy = accuracy
        self.lat = lat
        self.lng = lng
        self.locationType = locationType
        self.online = online
        self.speed = speed
        self.status = status
        self.time = time
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accuracy = try? container.decodeIfPresent(Double.self, forKey: .accuracy)
        self.lat = try? container.decodeIfPresent(Double.self, forKey: .lat)
        self.lng = try? container.decodeIfPresent(Double.self, forKey: .lng)
        self.locationType = try? container.decodeIfPresent(String.self, forKey: .locationType)
        self.online = try? container.decodeIfPresent(Bool.self, forKey: .online)
        self.speed = try? container.decodeIfPresent(Double.self, forKey: .speed)
        self.status = try? container.decodeIfPresent(String.self, forKey: .status)
        self.time = try? container.decodeIfPresent(Int64.self, forKey: .time)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encodeIfPresent(self.accuracy, forKey: .accuracy)
        try? container.encodeIfPresent(self.lat, forKey: .lat)
        try? container.encodeIfPresent(self.lng, forKey: .lng)
        try? container.encodeIfPresent(self.locationType, forKey: .locationType)
        try? container.encodeIfPresent(self.online, forKey: .online)
        try? container.encodeIfPresent(self.speed, forKey: .speed)
        try? container.encodeIfPresent(self.status, forKey: .status)
        try? container.encodeIfPresent(self.time, forKey: .time)
    }
}
struct NetResOrderOption: Codable {
    let id: Int?
    let cost: Double?
    let costType: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cost
        case costType = "cost_type"
        case name
    }
}

struct NetResOrderIntercity: Codable {
    let startHour: String?
    let endHour: String?
    let scheduleId: Int?
    let totalPrice: Double?
    let isBooked: Bool?
    let seatLayouts: [SeatLayout]?
    let isPostal: Bool?
    
    enum CodingKeys: String, CodingKey {
        case startHour = "start_hour"
        case endHour = "end_hour"
        case scheduleId = "schedule_id"
        case totalPrice = "total_price"
        case isBooked = "is_booked"
        case seatLayouts = "seat_layouts"
        case isPostal = "is_postal"
    }
    
    struct SeatLayout: Codable {
        let slug: String?
        let index: Int?
        let seatLayoutId: Int?
        let price: Double?
        
        enum CodingKeys: String, CodingKey {
            case slug
            case index
            case seatLayoutId = "seat_layout_id"
            case price
        }
    }
}

struct NetResOrderTariff: Codable {
    let id: Int?
    let name: String?
}
