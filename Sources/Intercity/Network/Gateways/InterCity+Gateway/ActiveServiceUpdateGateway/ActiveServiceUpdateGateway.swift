//
//  ActiveServiceUpdateGateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 15/10/25.
//

import SwiftUI
import NetworkLayer
import Core

protocol ActiveServiceUpdateGatewayProtocol {
    func updateActiveService(id: Int) async -> Bool
}

struct ActiveServiceUpdateGateway: ActiveServiceUpdateGatewayProtocol {
    func updateActiveService(id: Int) async -> Bool {
        let request = Request(serviceId: id)
        let result = NetRes<Bool>? = try await Network.sendThrow(request: request)
        let res: NetRes<DNetResValidate>? = try await

        return result?.result ?? false
    }
    
    struct Request: Codable, URLRequestProtocol {
        let serviceId: Int
        
        enum CodingKeys {
        case serviceId = "brand_service_id"
        }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/v2/executor-select/active-services")
        }
        
        var body: Data? {
            self.asData
        }
        
        var method: HTTPMethod {
            .post
        }
    }
}
