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
    func getDefaultTariff() async throws -> DriverDefaultTariffResponse?
}

public struct DefaultTariffGateway: DefaultTariffProtocol {
    public func getDefaultTariff() async throws -> DriverDefaultTariffResponse? {
        let result: NetRes<DriverDefaultTariffResponse>? = try await Network.sendThrow(request: Request())
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
