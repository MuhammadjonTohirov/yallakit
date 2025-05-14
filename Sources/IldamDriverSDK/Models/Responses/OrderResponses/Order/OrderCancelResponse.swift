//
//  OrderCancelModel.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI

public struct OrderCancelResponse {
    public let id: Int
    public let status: String
    
    public init(id: Int, status: String) {
        self.id = id
        self.status = status
    }
    
    init(from network: DNetOrderCancelResult) {
        self.id = network.id
        self.status = network.status
    }
}
