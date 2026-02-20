//
//  OrderHistoryGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/OrderHistoryGateway.swift
import Foundation
import NetworkLayer

protocol OrderHistoryGatewayProtocol {
    func loadHistory(page: Int, limit: Int) async -> NetResOrderHistory?
}

struct OrderHistoryGateway: OrderHistoryGatewayProtocol {
    func loadHistory(page: Int, limit: Int = 8) async -> NetResOrderHistory? {
        let result: NetRes<NetResOrderHistory>? = await Network.send(
            request: MainNetworkRoute.loadOrderHistory(limit: limit, page: page)
        )
        return result?.result
    }
}
