//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import NetworkLayer

protocol ShowAndReadNotifGateway {
    func execute(notificationId: Int) async throws -> NetResNotification?
}

struct ShowAndReadNotifGatewayImpl: ShowAndReadNotifGateway {
    struct Request: URLRequestProtocol {
        let notificationId: Int
        
        var url: URL {
            URL.baseAPICli.appending(path: "notification/show/\(notificationId)")
        }
        
        var body: Data?
        
        var method: NetworkLayer.HTTPMethod { .get }
    }
    
    func execute(notificationId: Int) async throws -> NetResNotification? {
        let request = Request(notificationId: notificationId)
        let res: NetRes<NetResNotification>? = try await Network.sendThrow(request: request)
        return res?.result
    }
}
