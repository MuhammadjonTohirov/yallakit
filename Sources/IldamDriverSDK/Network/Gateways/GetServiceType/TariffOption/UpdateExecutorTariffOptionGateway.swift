//
//  SendServiceTypeGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import Foundation
import NetworkLayer

protocol SendServiceTypeProtocol {
    func sendTariffOption(tariffId: [Int]) async throws -> Bool?
}

struct UpdateExecutorTariffOptionGateway: SendServiceTypeProtocol {
    func sendTariffOption(tariffId: [Int]) async throws -> Bool? {
        let request = Request(tariffOptions: tariffId)

        let response: NetRes<Bool>? = try await Network.send(request: request)
        
        return response?.success == true
    }
    
    struct Request: Encodable, URLRequestProtocol {
        var tariffOptions: [Int]

        enum CodingKeys: String, CodingKey {
            case tariffOptions = "tariff_options"
        }

        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/executor/option-update")
        }

        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        var method: HTTPMethod {
            .post
        }
    }
}
