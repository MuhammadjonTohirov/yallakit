//
//  IntercityOrderListGatewayProtocol.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 14/10/25.
//


protocol InterCityOrderShowGatewayProtocol {
    func getOrderList(id: Int) async throws -> InterCityOrderListResponse
}

struct InterCityOrderShowGatewayGateway: IntercityOrderListGatewayProtocol {
    func getOrderList(type: OrderListType, service: OrderServiceType) async throws -> InterCityOrderListResponse {
        let result: NetRes<InterCityOrderListResponse>? = await Network.send(request: MainNetworkRoute.getIntercityOrderList(type: type, service: service))
        
        return result.?.result ?? InterCityOrderListResponse(data: [])
    }
    
    
    struct  Request: CodingKey, URLRequestProtocol {
    
        let orderId: Int
        
        var method: HTTPMethod { .get }
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("/executor/v2/order/\(orderId)")
        }
        
        var data: Data? { nil }
    
    }
}
