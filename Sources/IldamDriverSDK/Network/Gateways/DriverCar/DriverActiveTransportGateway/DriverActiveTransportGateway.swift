//
//  DriverActiveTransportGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//


import Foundation
import NetworkLayer

protocol DriverActiveTransportProtocol {
    func sendTransportId(id:Int) async throws -> Bool?
}

struct DriverActiveTransportGateway: DriverActiveTransportProtocol {
    func sendTransportId(id:Int) async throws -> Bool? {
        
        let request = Request(transportId: id)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }
    
    struct Request: Codable, URLRequestProtocol {
        var transportId:Int
        enum CodingKeys: String, CodingKey {
            case transportId = "transport_id"
        }
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/active/transport")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod {
            .post
        }
        
    }
}
