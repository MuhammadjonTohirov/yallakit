//
//  OrderNetworkRoute.swift
//  Ildam
//
//  Created by applebro on 17/09/24.
//

import Foundation
import Core
import NetworkLayer

enum OrderNetworkRoute: URLRequestProtocol {
    var url: URL {
        switch self {
        case .activeOrders:
            return URL.goIldamAPI.appendingPathComponent("active/orders")
        case .order(let id):
            return URL.goIldamAPI.appendingPathComponent("order/\(id)")
        case .activeOrdersCount:
            return URL.goIldamAPI.appendingPathComponent("active/orders/count")
        case .cancelOrder(let id):
            return URL.goIldamAPI.appendingPathComponent("order/cancel/\(id.description)")
        case .cancelOrderReason(let orderId, _, _):
            return URL.goIldamAPI.appendingPathComponent("order/cancel/reason/\(orderId)")
        case .rateOrder:
            return URL.baseAPICli.appendingPathComponent("ratings")
        case .archivedOrder(let id):
            return URL.goIldamAPI.appendingPathComponent("order/archive/show/\(id.description)")
        case .orderSettings:
            return URL.goIldamAPI.appendingPathComponent("setting/config")
        }
    }
    
    var body: Data? {
        switch self {
        case let .rateOrder(orderId, rate, comment):
            return NetReqRateOrder.init(ball: rate, orderId: orderId, comment: comment).asData
        case let .cancelOrderReason(_, reasonId, reasonComment):
            return NetReqCancelOrderReason.init(reasonId: reasonId, reasonComment: reasonComment).asData
        default:
            return nil
        }
    }
    
    var method: NetworkLayer.HTTPMethod {
        switch self {
        case .cancelOrder, .cancelOrderReason:
            return .put
        case .rateOrder:
            return .post
        default:
            return .get
        }
    }
    
    func request() -> URLRequest {
        var request = URLRequest.new(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
    
    case activeOrders
    case order(id: Int)
    case activeOrdersCount
    case cancelOrder(id: Int)
    case cancelOrderReason(orderId: Int, reasonId: Int, reasonComment: String)
    case rateOrder(orderId: Int, rate: Int, comment: String)
    case archivedOrder(id: Int)
    case orderSettings
}
