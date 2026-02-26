//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import SwiftUI
import NetworkLayer

protocol ReadAllNotifsGateway: Sendable {
    func execute() async throws -> Bool
}

struct ReadAllNotifsGatewayImpl: ReadAllNotifsGateway {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    struct Request: URLRequestProtocol {
        var url: URL {
            return URL.baseAPICli.appendingPath("notification", "readed")
        }

        var body: Data? = nil

        var method: NetworkLayer.HTTPMethod { .post }
    }

    func execute() async throws -> Bool {
        let request = Request()
        let res: NetRes<String>? = try await client.sendThrow(request: request)

        return res?.success ?? false
    }
}
