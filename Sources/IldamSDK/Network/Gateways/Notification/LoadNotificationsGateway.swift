//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import NetworkLayer

protocol LoadNotificationsGatewayProtocol {
    func load(page: Int, perPage: Int) async throws -> NetResNotifications?
}

struct LoadNotificationsGateway: LoadNotificationsGatewayProtocol {
    struct Request: URLRequestProtocol {
        let page: Int
        let perPage: Int
        
        var url: URL {
            URL.goIldamAPI.appending(path: "notifications")
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
        let result: NetRes<NetResNotifications>? = try await Network.sendThrow(request: request)
        return result?.result
    }
}
