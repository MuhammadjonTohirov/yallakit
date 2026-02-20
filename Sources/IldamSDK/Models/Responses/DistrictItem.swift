//
//  DistrictItem.swift
//  YallaKit
//
//  Created by applebro on 20/02/26.
//

import Foundation

public struct DistrictItem: Sendable {
    public let id: Int
    public let name: String?
    public let level: String?
    public let parent: Parent?

    public struct Parent: Sendable {
        public let id: Int
        public let name: String

        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }

    public init(id: Int, name: String?, level: String?, parent: Parent?) {
        self.id = id
        self.name = name
        self.level = level
        self.parent = parent
    }
}

extension DistrictItem {
    init(networkResponse: NetResDistrictItem) {
        self.id = networkResponse.id
        self.name = networkResponse.name
        self.level = networkResponse.level
        self.parent = networkResponse.parent.map { Parent(id: $0.id, name: $0.name) }
    }
}
