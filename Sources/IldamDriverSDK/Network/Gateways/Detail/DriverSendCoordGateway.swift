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
    func sendCoords(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool?) async throws -> Bool
    func sendCoords(request _req: SendCoordsBody) async throws -> Bool
}

struct DriverSendCoordGateway: DriverSendCoordProtocol {
    
    func sendCoords(lat: Double, lng: Double, heading: Double, speed: Double, online: Bool? = nil) async throws -> Bool {
        let coords = SendCoords(
            heading: Int(heading),
            lat: lat,
            lng: lng,
            speed: (speed),
            orderStatus: "",
            orderId: nil,
            online: online,
            statusTime: ""
        )
        
        let request = Request(req: .init(coords: coords, orderCheck: nil))
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }
    
    func sendCoords(request _req: SendCoordsBody) async throws -> Bool {
        let request = Request(req: _req)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }
    
    private struct Request: URLRequestProtocol {
        let req: SendCoordsBody

        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/send-coords")
        }

        var body: Data? {
            try? JSONEncoder().encode(req)
        }

        var method: HTTPMethod { .post }
        
        enum CodingKeys: CodingKey {
            case coords
        }
    }
}
