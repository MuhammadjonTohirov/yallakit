//
//  NetResOrderHistory.swift
//  Ildam
//
//  Created by applebro on 19/01/24.
//

import Foundation

struct NetResOrderHistory: NetResBody {
    let list: [NetResOrderHistoryItem]
    
    init(list: [NetResOrderHistoryItem]) {
        self.list = list
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.list, forKey: .list)
    }
    
    enum CodingKeys: CodingKey {
        case list
        case pagination
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try container.decodeIfPresent([NetResOrderHistoryItem].self, forKey: .list) ?? []
    }
}

struct NetResOrderHistoryItem: Codable {
    let id: Int
    let dateTime: Double
    let service, status: String
    let track: [NetCoord]?
    let executor: NetResTaxiOrderExecutor?
    let taxi: NetResOrderTaxiDetails?
    let comment: String?
    let services: [NetResOrderHistoryService]?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.dateTime, forKey: .dateTime)
        try container.encode(self.service, forKey: .service)
        try container.encode(self.status, forKey: .status)
        try container.encodeIfPresent(self.track, forKey: .track)
        try container.encodeIfPresent(self.executor, forKey: .executor)
        try container.encodeIfPresent(self.taxi, forKey: .taxi)
        try container.encodeIfPresent(self.comment, forKey: .comment)
        try container.encode(self.services, forKey: .services)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.dateTime = try container.decodeIfPresent(Double.self, forKey: .dateTime) ?? 0
        self.service = try container.decodeIfPresent(String.self, forKey: .service) ?? ""
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        self.track = (try? container.decodeIfPresent([NetCoord].self, forKey: .track)) ?? []
        self.executor = try? container.decodeIfPresent(NetResTaxiOrderExecutor.self, forKey: .executor)
        self.taxi = try? container.decodeIfPresent(NetResOrderTaxiDetails.self, forKey: .taxi)
        self.comment = try? container.decodeIfPresent(String.self, forKey: .comment)
        self.services = (try? container.decodeIfPresent([NetResOrderHistoryService].self, forKey: .services)) ?? []
    }
    
    var dateString: String {
        let date = Date.init(timeIntervalSince1970: dateTime)
        if Calendar.current.isDateInToday(date) {
            return "today".localize
        }
        
        if Calendar.current.isDateInYesterday(date) {
            return "yesterday".localize
        }
        
        return date.toExtendedString(format: "dd.MM.yyyy")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case dateTime = "date_time"
        case service, status, track, executor, taxi, comment, services
    }
}

struct NetResOrderHistoryService: Codable {
    let id: Int
    let name: String
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

struct NetResOrderRoute: Codable {
    struct Coords: Codable {
        let lat, lng: Double
    }
    
    let index: Int?
    let fullAddress: String?
    let coords: Coords?
    
    enum CodingKeys: String, CodingKey {
        case index
        case fullAddress = "full_address"
        case coords
    }
}

struct NetResOrderHistoryAddress: Codable {
    let id: Int
    let name: String
}
