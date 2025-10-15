//
//  IntercityOrderListGateway.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 14/10/25.
//

import Foundation
import NetworkLayer

enum OrderListType {
    case ether
    case me
    
    enum CodingKeys: String, CodingKey {
        case ether
        case me
    }
    
    public init?(with: String) {
        
        switch with {
            case "ether":
            self = .ether
        case "me":
            self = .me
        default:
            return nil
        }
    }
}

enum OrderServiceType {
    case intercity
    case road
    
    enum CodingKeys: String, CodingKey {
        case intercity
        case road
    }
    
    public init?(with: String) {
        switch with {
            case "intercity":
            self = .intercity
        case "road":
            self = .road
        default:
            return nil
        }
    }
}

protocol IntercityOrderListGatewayProtocol {
    func getOrderList(type: OrderListType, service: OrderServiceType) async throws -> InterCityOrderListResponse 
}

struct IntercityOrderListGateway: IntercityOrderListGatewayProtocol {
    func getOrderList(type: OrderListType, service: OrderServiceType) async throws -> InterCityOrderListResponse {
        let result: NetRes<InterCityOrderListResponse>? = await Network.send(request: MainNetworkRoute.getIntercityOrderList(type: type, service: service))
        
        return result.?.result ?? InterCityOrderListResponse(data: [])
    }
    
    struct Request: URLRequestProtocol {

        let service: OrderServiceType?
        let type: OrderListType?
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("/executor/v2/orders?f=\(type)&service=\(service?.rawValue ?? "")")

            components?.queryItems = [
                URLQueryItem(name: "f", value: type),
                URLQueryItem(name: "service", value: service)
            ]
            
            guard let url = components?.url else {
                fatalError("Could not construct URL from components")
            }
            return url
        }
        
        var body: Data? { nil }
        var method: HTTPMethod { .get }
    }
}
