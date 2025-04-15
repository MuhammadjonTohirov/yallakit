//
//  MapNetworkRouter.swift
//  IldamMap
//
//  Created by applebro on 09/09/24.
//

import Foundation
import NetworkLayer
import Core

enum MainNetworkRoute: URLRequestProtocol {
    var url: URL {
        switch self {
        case .getAddress(let lat, let lng):
            return URL.goIldamAPI.appendingPath("location-name").appending(queryItems: [
                .init(name: "lat", value: "\(lat)"),
                .init(name: "lng", value: "\(lng)")
            ])
        }
    }
    
    var body: Data? {
        switch self {
        case let .getAddress(lat, lng):
            return [
                "lat": lat,
                "lng": lng
            ].asData
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAddress:
            return .post
        }
    }
    
    func request() -> URLRequest {
        var request: URLRequest = URLRequest.new(url: url)
        
        request = URLRequest.new(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return request
    }
    
    case getAddress(lat: Double, lng: Double)
}
