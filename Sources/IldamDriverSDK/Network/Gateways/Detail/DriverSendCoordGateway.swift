//
//  DriverSendCoordGateway.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//
//DriverSendCoordGateway

import Foundation
import NetworkLayer
import Core

protocol DriverSendCoordProtocol {
    func sendCoords(coords: SendCoordsBody) async throws -> Bool
}

struct DriverSendCoordGateway: DriverSendCoordProtocol {
    func sendCoords(coords: SendCoordsBody) async throws -> Bool {
        let request = Request(coordsBody: coords)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }

    struct Request: URLRequestProtocol {
        let coordsBody: SendCoordsBody
        
        enum CodingKeys: String, CodingKey {
            case coords
            case orderCheck = "order_ckeck"
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/send-coords")
        }
        
        var body: Data? {
            try? JSONEncoder().encode(coordsBody)
        }
        
        var method: HTTPMethod { .post }
    }
}

