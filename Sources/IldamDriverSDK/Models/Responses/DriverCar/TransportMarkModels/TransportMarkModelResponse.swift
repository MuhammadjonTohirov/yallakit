//
//  TransportMarkModelResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

public struct TransportMarkModelResponse: DNetResBody {
    public let id: Int
    public let name: String
    public let models: [TransportName]
    
    
    public init(id: Int, name: String, models: [TransportName]) {
        self.id = id
        self.name = name
        self.models = models
    }
    init(from network: DNetTransportMarkModelsResponse) {
        self.id = network.id
        self.name = network.name
        self.models = network.models.map { TransportName(from: $0) }
    }


    public struct TransportName: Codable {
        let id: Int
        let name: String
        
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
        init(from network: DNetCarNameResponse) {
            
            self.id = network.id
            self.name = network.name
        }
    }
}
