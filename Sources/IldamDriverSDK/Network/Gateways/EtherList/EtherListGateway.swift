//
//  EtherListGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol EtherListGetwayProtocol {
    func getEtherList(type: String) async throws -> DNetResEtherResponse?
}

struct EtherListGateway: EtherListGetwayProtocol {
    func getEtherList(type: String) async throws -> DNetResEtherResponse? {
        
        let result: NetRes<DNetResEtherResponse>? = try await Network.sendThrow(request: Request(type: type))
        
        return result?.result
    }
    
    struct Request: Codable,URLRequestProtocol {
        var type: String
            
        var url: URL {
            URL.baseAPI
                .appending(path: "executor")
                .appending(path: "orders")
                .appending(queryItems: [
                    .init(name: "f", value: type)
                ])
        }

        
        var body: Data? { nil }
        
        var method: HTTPMethod {
            .get
        }

    }
    
    
}
