//
//  OrderCanceledFromPanelResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//

import Foundation

public struct OrderCanceledFromPanelResponse: Codable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
    init(from network: DNetOrderCanceledFromPanel) throws {
        self.id = network.id
    }
}

