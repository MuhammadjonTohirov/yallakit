//
//  DriverOrderShowGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//
import Foundation
import NetworkLayer
import Core

protocol DriverOrderShowGetwayProtocol {
    func getDriverOrderShow(orderId: Int) async throws -> DNetOrderShowResponse?
}

struct DriverOrderShowGateway: DriverOrderShowGetwayProtocol {
    func getDriverOrderShow(orderId: Int) async throws -> DNetOrderShowResponse? {
        let result: NetRes<DNetOrderShowResponse>? = try await Network.sendThrow(request: Request(orderId: orderId))
        return result?.result
    }
    
    struct Request: Codable, URLRequestProtocol {
        let orderId: Int
        
        var url: URL {
            return URL.baseAPI
                .appending(path: "executor")
                .appendingPathComponent("order-show/\(orderId)")
        }
        
        var body: Data? { nil }
        
        var method: HTTPMethod {
            .get
        }
        
        func request() -> URLRequest {
            var request = URLRequest.new(url: url)
            return request
        }
    }
}
 
