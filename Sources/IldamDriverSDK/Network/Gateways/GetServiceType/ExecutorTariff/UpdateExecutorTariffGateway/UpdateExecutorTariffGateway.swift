//
//  UpdateExecutorTariffGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation
import NetworkLayer

protocol UpdateExecutorTariffGatewayProtocol {
    func fetchExecutorTariffs(tariffId: [Int]) async throws -> Bool
}

struct UpdateExecutorTariffGateway: UpdateExecutorTariffGatewayProtocol {
    
    func fetchExecutorTariffs(tariffId: [Int]) async throws -> Bool {
        let request = Request(tariffIds: tariffId)
        let response: NetRes<Bool>? = try await Network.send(request: request)
    
        return response?.success == true
    }

    struct Request: URLRequestProtocol {
        var url: URL { URL.baseAPIPHP.appendingPathComponent("api/executor/tariff-update") }
        var tariffIds: [Int] = []
        
        enum CodingKeys: String, CodingKey {
            case taxiTariffs = "taxi_tariffs"
        }
        var body: Data? {
        
            self.tariffIds.asData
        }
        var method: HTTPMethod { .post }
    }
}
