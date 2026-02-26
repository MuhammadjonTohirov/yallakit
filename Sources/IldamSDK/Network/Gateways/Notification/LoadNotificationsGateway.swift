//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import NetworkLayer

protocol LoadNotificationsGatewayProtocol: Sendable {
    func load(page: Int, perPage: Int) async throws -> NetResNotifications?
}

struct LoadNotificationsGateway: LoadNotificationsGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    struct Request: URLRequestProtocol {
        let page: Int
        let perPage: Int

        var url: URL {
            URL.baseAPICli.appending(path: "notifications")
                .appending(queryItems: [
                    .init(name: "per_page", value: perPage.description),
                    .init(name: "page", value: page.description)
                ])
        }

        var body: Data? = nil

        var method: NetworkLayer.HTTPMethod { .get }
    }

    func load(page: Int, perPage: Int) async throws -> NetResNotifications? {
        let request = Request(page: page, perPage: perPage)
        let result: NetRes<NetResNotifications>? = try await client.sendThrow(request: request)
        return result?.result
    }
}
