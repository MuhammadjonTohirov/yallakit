//
//  OrderCanceledFromPanelResponse 2.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//


public struct OrderRemoveFromAppointedExecutorResponse: Codable {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
    init(from network: DNetOrderRemoveFromAppointedExecutor) throws {
        self.id = network.id
    }
}
