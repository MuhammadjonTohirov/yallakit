//
//  DriverFirebaseTookenGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import Foundation
import NetworkLayer

protocol DriverFirebaseTookenGatewayProtocol {
    func sendTooken(tooken: String) async throws -> Bool?
}

struct DriverFirebaseTookenGateway: DriverFirebaseTookenGatewayProtocol {
    func sendTooken(tooken: String) async throws -> Bool? {
        let request = Request(fcmToken: tooken)
        let response: NetRes<Bool>? = try await Network.send(request: request)
        
       
        return response?.result == true
    }
    
    struct Request: Encodable, URLRequestProtocol {
        let fcmToken: String
        
        enum CodingKeys: String, CodingKey {
            case fcmToken = "fcm_token"
        }
        
        var url: URL {
            URL.baseAPIPHP.appendingPathComponent("api/fcm/token")
        }
        
        var body: Data? {
            try? JSONEncoder().encode(self)
        }
        
        var method: HTTPMethod { .post }
    }

}
