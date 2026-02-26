//
//  CheckLocationGateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 20/10/25.
//

import SwiftUI
import NetworkLayer

protocol CheckLocationGatewayProtocol: Sendable {
    func checkLocation(lat: Double, lng: Double) async throws -> NetCheckLocationRes
}

struct CheckLocationGateway: CheckLocationGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func checkLocation(lat: Double, lng: Double) async throws -> NetCheckLocationRes {
        let request = Request(lat: lat, lng: lng)
        let result: NetRes<NetCheckLocationRes>? = await client.send(request: request)
        
        guard let data = result?.result else {
            throw NSError(domain: result?.error ?? "No Location", code: result?.code ?? -1)
        }
        return data
    }
}

extension CheckLocationGateway {
    
    struct Request: Codable, URLRequestProtocol {
        
        var lat: Double?
        var lng: Double?
        
        enum CodingKeys: String, CodingKey {
            case lat,lng
        }
        var url: URL {
            URL.goIldamAPI.appendingPathComponent("/check-location")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: NetworkLayer.HTTPMethod {
            .post
        }
        
        func request() -> URLRequest {
            var request = URLRequest.new(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            return request
        }
    }
}
