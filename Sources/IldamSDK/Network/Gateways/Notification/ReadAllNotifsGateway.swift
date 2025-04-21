//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation
import SwiftUI
import NetworkLayer

protocol ReadAllNotifsGateway {
    func execute() async throws -> Bool
}

struct ReadAllNotifsGatewayImpl: ReadAllNotifsGateway {
    struct Request: URLRequestProtocol {
        var url: URL {
            return URL.goIldamAPI.appendingPath("notification", "readed")
        }
        
        var body: Data? = nil
        
        var method: NetworkLayer.HTTPMethod { .post }
    }
    
    func execute() async throws -> Bool {
        let request = Request()
        let res: NetRes<String>? = try await Network.sendThrow(request: request)
        
        return res?.success ?? false
    }
}
