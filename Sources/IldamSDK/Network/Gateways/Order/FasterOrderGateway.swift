//
//  FasterOrderGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 03/04/25.
//

import Foundation
import NetworkLayer

protocol FasterOrderGateway {
    func getFasterOrder(orderId: Int) async -> Bool
}

struct FastOrderGatewayImpl: FasterOrderGateway {
    func getFasterOrder(orderId: Int) async -> Bool {
        let res: NetRes<String>? = await Network.send(request: Request(orderId: orderId))
        return res?.success ?? false
    }
}

extension FastOrderGatewayImpl {
    struct Request: URLRequestProtocol {
        var orderId: Int
        var url: URL {
            URL.goIldamAPI.appending(path: "order/faster/\(orderId)")
        }
        var body: Data? = nil
        var method: NetworkLayer.HTTPMethod = .get
    }
}
