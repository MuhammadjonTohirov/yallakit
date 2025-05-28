//
//  DNetOrderAppointResult.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/05/25.
//

import Foundation

public struct OrderAppointedResponses: DNetResBody {
    public let id: Int
    public let status: String?
    
    public init(id: Int, status: String?) {
        self.id = id
        self.status = status
    }
    init(from network: DNetOrderAppointResult) throws {
        self.id = network.id
        self.status = network.status
    }
}
