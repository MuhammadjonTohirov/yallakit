//
//  OrderUpdate.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

public struct OrderUpdateResponse: DNetResBody {
    public let id: String
    public let status: String
    
    public init(id: String, status: String) {
        self.id = id
        self.status = status
    }
    
    init(from network: DNetOrderStatusUpdateResponse) {
        self.id = network.id
        self.status = network.status
    }
}
