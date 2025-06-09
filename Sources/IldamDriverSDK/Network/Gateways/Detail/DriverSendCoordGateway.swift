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
    func sendCoordsWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double) async throws -> Bool
    func sendCoordsWithOrder(body: SendCoordsBody) async throws -> Bool
}

struct DriverSendCoordGateway: DriverSendCoordProtocol {
    
    func sendCoordsWithoutOrder(lat: Double, lng: Double, heading: Double, speed: Double) async throws -> Bool {
        let coords = SendCoords(
            heading: Int(heading),
            lat: lat,
            lng: lng,
            speed: (speed),
            orderStatus: "",
            orderId: nil,
            online: true,
            statusTime: ""
        )
        
        let request = Request(coords: coords)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }

    func sendCoordsWithOrder(body: SendCoordsBody) async throws -> Bool {
        let request = FullRequest(coordsBody: body)
        let response: NetRes<Bool>? = try await Network.sendThrow(request: request)
        return response?.success == true
    }

    private struct Request: URLRequestProtocol {
        let coords: SendCoords

        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/send-coords")
        }

        var body: Data? {
            try? JSONEncoder().encode(coords)
        }

        var method: HTTPMethod { .post }
    }

    private struct FullRequest: URLRequestProtocol {
        let coordsBody: SendCoordsBody

        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/send-coords")
        }

        var body: Data? {
            try? JSONEncoder().encode(coordsBody)
        }

        var method: HTTPMethod { .post }
    }
}
