//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public struct NotificationsResponse {
    public var list: [NotificationItem]?
    public var pagination: PaginationItem?
    
    public init(list: [NotificationItem], pagination: PaginationItem? = nil) {
        self.list = list
        self.pagination = pagination
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

public struct PaginationItem: Codable {
    public let total: Int?
    public let count: Int?
    public let perPage: Int?
    public let currentPage: Int?
    public let totalPages: Int?
    public let lastPage: Int?
    
    public init(total: Int, count: Int, perPage: Int, currentPage: Int, totalPages: Int, lastPage: Int) {
        self.total = total
        self.count = count
        self.perPage = perPage
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.lastPage = lastPage
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

extension PaginationItem {
    init?(res: NetResPagination?) {
        guard let res else { return nil }
        total = res.total
        count = res.count
        perPage = res.perPage
        currentPage = res.currentPage
        totalPages = res.totalPages
        lastPage = res.lastPage
    }
}

extension NotificationsResponse {
    init?(res: NetResNotifications?) {
        guard let res else { return nil }
        self.list = res.list?.compactMap(NotificationItem.init)
        self.pagination = res.pagination.flatMap(PaginationItem.init)
    }
}
