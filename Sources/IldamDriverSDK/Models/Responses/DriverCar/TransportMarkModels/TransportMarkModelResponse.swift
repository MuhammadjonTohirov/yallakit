//
//  TransportMarkModelResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import Foundation

struct TransportMarkModelResponse: DNetResBody {
    let id: Int
    let name: String
    let model: [DNetCarNameResponse]
    
    public init(id: Int, name: String, model: [DNetCarNameResponse]) {
        self.id = id
        self.name = name
        self.model = model
    }
    init(from network: DNetTransportMarkModelsResponse) {
        self.id = network.id
        self.name = network.name
        self.model = network.models
        
    }
    struct TransportModel: Codable {
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
