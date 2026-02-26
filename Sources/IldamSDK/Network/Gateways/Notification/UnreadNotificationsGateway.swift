//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import NetworkLayer


protocol UnreadNotificationsGatewayProtocol: Sendable {
    func execute() async throws -> Int?
}

struct UnreadNotificationsGateway: UnreadNotificationsGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    struct Request: URLRequestProtocol {
        var url: URL {
            URL.baseAPICli.appending(path: "/notification/count")
        }

        var body: Data?

        var method: NetworkLayer.HTTPMethod = .get
    }

    func execute() async throws -> Int? {
        let request = Request()
        let res: NetRes<Int>? = try await client.sendThrow(request: request)
        return res?.result
    }
}

extension Int: NetResBody {
    
}
