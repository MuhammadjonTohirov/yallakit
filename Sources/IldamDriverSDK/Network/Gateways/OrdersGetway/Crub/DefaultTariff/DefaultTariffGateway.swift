//
//  DefaultTariffProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import Foundation
import NetworkLayer
import Core

protocol DefaultTariffProtocol {
    func getDefaultTariff() async throws -> DNetDefaultTariffResult?
}

struct DefaultTariffGateway: DefaultTariffProtocol {
    public func getDefaultTariff() async throws -> DNetDefaultTariffResult? {
        let result: NetRes<DNetDefaultTariffResult>? = try await Network.sendThrow(request: Request())
        return result?.result
    }

    struct Request: Codable, URLRequestProtocol {
        var url: URL {
            URL.baseAPI
                .appendingPathComponent("executor/curb-default")
        }

        var body: Data? { nil }

        var method: HTTPMethod { .get }
    }
}
