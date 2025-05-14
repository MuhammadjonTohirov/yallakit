//
//  ServiceType.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation

public struct ServiceType {
    public let id: Int
    public let name: String
    public let checked: Bool
    public let `default`: Bool

    public init(id: Int, name: String, isChecked: Bool, isDefault: Bool) {
        self.id = id
        self.name = name
        self.checked = isChecked
        self.`default` = isDefault
    }
    
    init(from network: DNetServiceTypeItem) {
        self.id = network.id
        self.name = network.name
        self.checked = network.check
        self.`default` = network.default
    }
}
