//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public struct NotificationsResponse {
    public var list: [NotificationItem]?
    
    public init(list: [NotificationItem]) {
        self.list = list
    }
}

public struct NotificationItem {
    public let id: Int?
    public let title: String?
    public let content: String?
    public let createdAt: Int?
    public let readed: Bool?
    public let image: String?
    
    public init(id: Int, title: String, content: String, createdAt: Int, readed: Bool, image: String?) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.readed = readed
        self.image = image
    }
}

extension NotificationItem {
    init?(res: NetResNotification?) {
        guard let res else { return nil }
        id = res.id
        title = res.title
        content = res.content
        createdAt = res.createdAt
        readed = res.readed
        image = res.image
    }
}

extension NotificationsResponse {
    init?(res: NetResNotifications?) {
        guard let res else { return nil }
        self.list = res.list?.compactMap(NotificationItem.init)
    }
}
