//
//  AddressNetworkRouter.swift
//  IMap
//
//  Created by applebro on 11/09/24.
//

import Foundation
import NetworkLayer

struct PolygonNetworkRoute: URLRequestProtocol {
    
    var url: URL {
        URL.goIldamAPI.appendingPath("address", "polygon")
    }
    
    var body: Data? = nil
    
    var method: NetworkLayer.HTTPMethod {
        .get
    }
    
    func request() -> URLRequest {
        var request: URLRequest = URLRequest.new(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
}
