//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

struct NetResNotifications: NetResBody {
    var list: [NetResNotification]?
}

struct NetResNotification: NetResBody {
    let id: Int?
    let title: String?
    let content: String?
    let createdAt: Int?
    let readed: Bool?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
        case readed
        case image
    }
}
