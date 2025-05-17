//
//  DriverColorList.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

public struct DriverColorList {
    public let id: Int
    public let color: String
    public let name: String
    
    public init(id: Int, color: String, name: String) {
        self.id = id
        self.color = color
        self.name = name
    }

    init(from network: DNetCarColorListResponse) {
        self.id = network.id
        self.color = network.color
        self.name = network.name
    }
}
