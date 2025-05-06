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
    public let isChecked: Bool
    public let isDefault: Bool

    public init(id: Int, name: String, isChecked: Bool, isDefault: Bool) {
        self.id = id
        self.name = name
        self.isChecked = isChecked
        self.isDefault = isDefault
    }
    
    init(from network: DNetServiceTypeItem) {
        self.id = network.id
        self.name = network.name
        self.isChecked = network.check
        self.isDefault = network.default
    }
}
