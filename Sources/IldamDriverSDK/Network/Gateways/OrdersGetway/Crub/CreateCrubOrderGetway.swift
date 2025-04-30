//
//  CreateCrubOrderGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol CreateCrubOrderGetwayProtocol {
    func create(lat: Double,lng: Double,tariffId: Int,name: String) async throws -> DNetCrubOrderResponse?
}

struct CreateCrubOrderGetway: CreateCrubOrderGetwayProtocol {
    func create(lat: Double,lng: Double,tariffId: Int,name: String) async throws -> DNetCrubOrderResponse? {
        let request = Request(
            lat: lat,
            lng: lng,
            tariffId: tariffId,
            name: name
        )
        let result: NetRes<DNetCrubOrderResponse>? = try await Network.sendThrow(request: request)
        return result?.result
    }

    struct Request: Codable, URLRequestProtocol {
        let lat: Double
        let lng: Double
        let tariffId: Int
        let name: String

        enum CodingKeys: String, CodingKey {
            case lat
            case lng
            case tariffId = "tariff_id"
            case name
        }

        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/curb-create")
        }

        var body: Data? {
            try? JSONEncoder().encode(self)
        }

        var method: HTTPMethod { .post }
    }

}

 
