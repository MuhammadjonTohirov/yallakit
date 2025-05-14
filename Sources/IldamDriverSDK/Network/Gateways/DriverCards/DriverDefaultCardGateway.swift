//
//  DriverDefaultCardGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol DriverDefaultCardPrpotocol {
    func getDefaultCard(cardId: String) async throws -> Bool?
}

struct DriverDefaultCardGateway: DriverDefaultCardPrpotocol {
    func getDefaultCard(cardId: String) async throws -> Bool? {
        
        let request = Request(cardId: cardId)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
        
    }
    struct Request: URLRequestProtocol {
        
        var cardId: String?
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/select/default/card/\(cardId)")
        }
        
        var body: Data? {
            nil
        }
        
        var method: HTTPMethod { .put }
    }
    
}
