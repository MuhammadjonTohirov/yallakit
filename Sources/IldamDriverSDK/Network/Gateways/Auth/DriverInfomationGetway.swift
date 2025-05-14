//
//  DriverInfomationGetway.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import Foundation
import NetworkLayer

protocol DriverInfomationGetwayProtocol {
    func getDriverInfo() async throws -> DNetResDriverInformationResponse
}

struct DriverInfomationGetway: DriverInfomationGetwayProtocol {
    func getDriverInfo() async throws -> DNetResDriverInformationResponse {
        let res: NetRes<DNetResDriverInformationResponse>? = try await Network.sendThrow(request: Request())

        guard let result = res?.result else {
            throw NetworkError.emptyResponse
        }

        return result
    }

    struct Request: Codable,URLRequestProtocol {
        var url: URL {
            URL.baseAPIPHP.appending(path: "api/auth/me")
        }
        
        var body: Data? {
            self.asData
        }
        var method: HTTPMethod {
            .post
        }
        
        
    }
    
}
