//
//  DriverFotoControlResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import SwiftUI
import Foundation

public struct DriverFotoControlItem: Codable {
    public let id: Int
    public let shape: String
    public let title: String
    public let type: String

    public init(id: Int, shape: String, title: String, type: String) {
        self.id = id
        self.shape = shape
        self.title = title
        self.type = type
    }

    init(from network: DNetFotoControlItem) {
        self.id = network.id
        self.shape = network.shape
        self.title = network.title
        self.type = network.type
    }
}
