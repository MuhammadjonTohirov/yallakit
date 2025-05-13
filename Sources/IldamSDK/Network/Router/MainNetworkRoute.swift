//
//  MainNetworkRoute.swift
//  Ildam
//
//  Created by applebro on 19/12/23.
//

import Foundation
import NetworkLayer

enum MainNetworkRoute: URLRequestProtocol {
    var url: URL {
        switch self {
        case .getAddress(let lat, let lng):
            return URL.goIldamAPI.appendingPath("location-name").appending(queryItems: [
                .init(name: "lat", value: "\(lat)"),
                .init(name: "lng", value: "\(lng)")
            ])
        case .getTariffs:
            return URL.goIldamAPI.appendingPath("address", "tariff", "cost")
        case .searchAddress:
            return URL.goIldamAPI.appendingPath("location", "search")
        case .getMyAddresses:
            return URL.baseAPICli.appendingPath("client", "addresses")
        case .addMyAddress:
            return URL.baseAPICli.appendingPath("client", "addresses")
        case .updateMyAddress(_, let id):
            return URL.baseAPICli.appendingPath("client", "addresses", "\(id)")
        case .getRouteCoordinates:
            return URL.goIldamAPI.appendingPath("address", "tariff", "cost")
        case .deleteAddress(let id):
            return URL.baseAPICli.appendingPath("client", "addresses", "\(id)")
        case let .getNearAddresses(lat, lng):
            return URL.baseAPICli.appendingPath("near", "address").appending(queryItems: [
                .init(name: "lat", value: "\(lat)"),
                .init(name: "lng", value: "\(lng)")
            ])
        case .findExecutors(let req):
            var queries: [URLQueryItem] = [
                .init(name: "lat", value: req.lat),
                .init(name: "lng", value: req.lng),
                .init(name: "tariff_options", value: req.tariffOptions.reduce("", { (result, next) -> String in
                    return result + "\(next),"
                }))
            ]
            
            if let id = req.tariffId {
                queries.append(.init(name: "tariff_id", value: "\(id)"))
            }
            
            return URL.goIldamAPI.appendingPath("executor", "lists")
                .appending(queryItems: queries)
            
        case let .loadOrderHistory(limit, page):
            return URL.goIldamAPI
                .appending(path: "orders")
                .appending(path: "archive")
                .queries(
                    .init(name: "per_page", value: "\(limit)"),
                    .init(name: "page", value: "\(page)")
                )
        case .orderTaxi:
            return URL.goIldamAPI.appendingPath("create")
        case .orderDetails(let orderId):
            return URL.goIldamAPI.appendingPath("order", "\(orderId)")
        }
    }
    
    var body: Data? {
        switch self {
        case .getTariffs(let req):
            return req.asData
        case .addMyAddress(let req):
            return req.asData
        case .updateMyAddress(let req, _):
            return req.asData
        case .getRouteCoordinates(let req):
            return req.asData
        case .orderTaxi(let req):
            return req.asData
        case let .searchAddress(text, lat, lng):
            let dict: [String : Any] = [
                "lat": lat,
                "lng": lng,
                "q": text
            ]
            
            return try? JSONSerialization.data(withJSONObject: dict)
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAddress, .getMyAddresses, .loadOrderHistory, .orderDetails, .findExecutors:
            return .get
        case .getTariffs, .addMyAddress, .getRouteCoordinates, .getNearAddresses, .orderTaxi, .searchAddress:
            return .post
        case .updateMyAddress:
            return .put
        case .deleteAddress:
            return .delete
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
    case getNearAddresses(lat: Double, lng: Double)
    case getTariffs(req: NetReqTaxiTariff)
    case searchAddress(text: String, lat: Float, lng: Float)
    case getMyAddresses
    case addMyAddress(req: NetReqAddAddress)
    case updateMyAddress(req: NetReqEditAddress, id: Int)
    case getRouteCoordinates(req: NetReqTaxiTariff)
    case deleteAddress(id: Int)
    case findExecutors(req: NetReqExecutors)
    case loadOrderHistory(limit: Int, page: Int)
    case orderTaxi(req: NetReqOrderTaxi)
    case orderDetails(orderId: Int)
}
