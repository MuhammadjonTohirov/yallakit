//
//  UserInfo.swift
//  Core
//
//  Created by applebro on 09/09/24.
//

import Foundation

public struct UserInfo: Codable {
    public var id: Int
    public var phone: String
    public var givenNames: String?
    public var surName: String?
    public var block: Bool?
    public var orderCount: Int?
    public var balance: Float?
    public var busyBalance: Float?
    public var blockNote: String?
    public var rating: String?
    public var blockDate: String?
    public var blockSource: String?
    public var image: String?
    public var blockExpiry: String?
    public var services: [String]?
    public var createdAt: String?
    public var lastActivity: String?
    public var birthday: String?
    public var gender: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case phone
        case givenNames = "given_names"
        case surName = "sur_name"
        case block
        case orderCount = "order_count"
        case balance
        case busyBalance = "busy_balance"
        case blockNote = "block_note"
        case rating
        case blockDate = "block_date"
        case blockSource = "block_source"
        case image
        case blockExpiry = "block_expiry"
        case services
        case createdAt = "created_at"
        case lastActivity = "last_activity"
        case birthday
        case gender
    }
    
    public init(id: Int, phone: String, givenNames: String? = nil, surName: String? = nil, block: Bool? = nil, orderCount: Int? = nil, balance: Float? = nil, busyBalance: Float? = nil, blockNote: String? = nil, rating: String? = nil, blockDate: String? = nil, blockSource: String? = nil, image: String? = nil, blockExpiry: String? = nil, services: [String]? = nil, createdAt: String? = nil, lastActivity: String? = nil, birthday: String? = nil, gender: String? = nil) {
        self.id = id
        self.phone = phone
        self.givenNames = givenNames
        self.surName = surName
        self.block = block
        self.orderCount = orderCount
        self.balance = balance
        self.busyBalance = busyBalance
        self.blockNote = blockNote
        self.rating = rating
        self.blockDate = blockDate
        self.blockSource = blockSource
        self.image = image
        self.blockExpiry = blockExpiry
        self.services = services
        self.createdAt = createdAt
        self.lastActivity = lastActivity
        self.birthday = birthday
        self.gender = gender
    }
}

public extension UserInfo {
    var fullName: String {
        var name = ""
        
        if let givenNames = givenNames {
            name += givenNames
        }
        if let surName = surName {
            name += " " + surName
        }
        return name
    }
    
    var imageURL: URL? {
        if let image = image {
            return URL(string: image)
        }
        return nil
    }
    
    var formattedPhone: String {
        phone.format(with: "XXXX XX XXX-XX-XX")
    }
}
