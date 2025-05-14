//
//  FillDriverBalance.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//


import Foundation
import NetworkLayer
import Core

protocol FillDriverCardToBalanceProtocol {
    func getDefaultCard(cardId: String, amount: Double) async throws -> Bool?
}

struct FillDriverCardToBalanceGateway: FillDriverCardToBalanceProtocol {
    func getDefaultCard(cardId: String, amount: Double) async throws -> Bool? {
        let request = Request(cardId: cardId, amount: amount)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    
    }
    
    struct Request: Encodable, URLRequestProtocol {
        let cardId: String
        let amount: Double
        
        enum CodingKeys: String, CodingKey {
            case amount
            case cardId = "card_id"
        }
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/card/pay/create")
        }
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        var method: HTTPMethod { .post }
    }
}
