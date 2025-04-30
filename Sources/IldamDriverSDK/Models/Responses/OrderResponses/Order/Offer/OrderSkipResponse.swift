//
//  DNetOrderSkipResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//


public struct OrderSkipResponse: DNetResBody {
    
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
    
    init(from network: DNetOrderSkipResponse) {
        self.id = network.id
    }
}
