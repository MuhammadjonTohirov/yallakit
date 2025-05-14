//
//  OrderTariffConfigurationGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

import Foundation
import Core
import SwiftUI
import NetworkLayer

protocol OrderTariffConfigurationGatewayProtocol {
    func getOrderTariffConfiguration(orderId: Int) async throws -> DNetOrderTariffConfigResponse?
}

 struct OrderTariffConfigurationGateway: OrderTariffConfigurationGatewayProtocol {
     func getOrderTariffConfiguration(orderId: Int) async throws -> DNetOrderTariffConfigResponse? {
        let response: NetRes<DNetOrderTariffConfigResponse>? = try await Network.sendThrow(request: Request(orderId: orderId))
        return response?.result
    }
    
    struct Request: URLRequestProtocol {
        let orderId: Int
        
        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/tariff-configs/\(orderId)")
        }
        
        var body: Data? { nil }
        
        var method: HTTPMethod {
            .get
        }
        func request() -> URLRequest {
            let request = URLRequest.new(url: url)

            return request
        }
        
    }
}
