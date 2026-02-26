//
//  AddressParent.swift
//  Core
//
//  Created on 26/02/26.
//

import Foundation

public struct AddressParent: Codable, Sendable {
    public var id: Int64
    public var name: String?
    public var level: String?

    public init(id: Int64, name: String? = nil, level: String? = nil) {
        self.id = id
        self.name = name
        self.level = level
    }

    @available(*, deprecated, renamed: "init(id:name:level:)")
    public init(id: Int64, name: String? = nil, lavel: String? = nil) {
        self.init(id: id, name: name, level: lavel)
    }
}
