//
//  SendServiceTypeProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation
import NetworkLayer

protocol UpdateExecutorTariffClassProtocol {
    func sendTariffOption(tariffClassIDs: [Int]) async throws -> Bool?
}

struct UpdateExecutorTariffClassGateway: UpdateExecutorTariffClassProtocol {
    func sendTariffOption(tariffClassIDs: [Int]) async throws -> Bool? {
        let request = Request(tariffClassIDs: tariffClassIDs)

        let response: NetRes<Bool>? = try await Network.send(request: request)
        
        return response?.success == true
    }
    
    struct Request: Encodable, URLRequestProtocol {
        var tariffClassIDs : [Int]

        enum CodingKeys: String, CodingKey {
            case tariffClassIDs = "class"
        }

        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/executors/class")
        }

        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        var method: HTTPMethod {
            .post
        }
    }
}
