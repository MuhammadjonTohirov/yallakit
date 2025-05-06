//
//  SendFotoControlGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import Foundation
import NetworkLayer
import Core

protocol SendFotoControlGatewayProtocol {
    func sendPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool
}

struct SendFotoControlGateway: SendFotoControlGatewayProtocol {
    func sendPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool {
        let request = Request(bodyItems: body)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }

    struct Request: URLRequestProtocol {
        let bodyItems: [SendFotoControlBodyItem]
        
        enum CodingKeys: String, CodingKey {
            case type
            case photoControlId = "photo_control_id"
            case file
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/photo-control")
        }

        var body: Data? {
            try? JSONEncoder().encode(bodyItems)
        }

        var method: HTTPMethod { .post }
    }
}
