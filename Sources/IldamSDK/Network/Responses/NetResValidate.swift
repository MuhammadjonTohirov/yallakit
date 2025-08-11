//
//  NetResValidate.swift
//  Ildam
//
//  Created by applebro on 07/12/23.
//

import Foundation
import Core

struct NetResValidate: NetResBody {
    let key: String?
    let isClient: Bool
    let client: NetResClient?
    let accessToken: String?
    let expiresIn: Int?
    
    enum CodingKeys: String, CodingKey {
        case key
        case isClient = "is_client"
        case client
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
    
    var expirationDate: Date {
        var date = Date()
        date.addTimeInterval(TimeInterval(expiresIn ?? 0))
        return date
    }
    
    init(isClient: Bool, client: NetResClient?, accessToken: String?, expiresIn: Int?, key: String?) {
        self.isClient = isClient
        self.client = client
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.key = key
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isClient = try container.decode(Bool.self, forKey: .isClient)
        self.client = try container.decodeIfPresent(NetResClient.self, forKey: .client)
        self.accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        self.expiresIn = try container.decodeIfPresent(Int.self, forKey: .expiresIn)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.isClient, forKey: .isClient)
        try container.encodeIfPresent(self.client, forKey: .client)
        try container.encodeIfPresent(self.accessToken, forKey: .accessToken)
        try container.encodeIfPresent(self.expiresIn, forKey: .expiresIn)
        try container.encodeIfPresent(self.key, forKey: .key)
    }
}

struct NetResClient: Codable {
    var id: Int
    var phone: String
    var givenNames: String?
    var surName: String?
    var block: Bool?
    var orderCount: Int?
    var balance: Float?
    var busyBalance: Float?
    var blockNote: String?
    var rating: String?
    var blockDate: String?
    var blockSource: String?
    var image: String?
    var blockExpiry: String?
    var services: [String]?
    var brand: NetResBrand?
    var createdAt: String?
    var lastActivity: String?
    var gender: Gender?
    var birthday: String?
    
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
        case blockDate = "block_date"
        case blockSource = "block_source"
        case image
        case blockExpiry = "block_expiry"
        case services
        case brand
        case createdAt = "created_at"
        case lastActivity = "last_activity"
        case gender
        case birthday
    }
}

struct NetResBrand: Codable {
    var id: Int
    var name: String
}
