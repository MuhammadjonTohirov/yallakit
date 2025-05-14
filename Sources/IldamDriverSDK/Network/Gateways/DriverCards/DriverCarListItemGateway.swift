//
//  DriverCarListItem.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation
import NetworkLayer

protocol DriverCardListGatewayProtocol {
    func fetchCardList() async throws -> [DNetCardListItem]?
}

struct DriverCardListGateway: DriverCardListGatewayProtocol {
    func fetchCardList() async throws -> [DNetCardListItem]? {
        let request = Request()
        let result: NetRes<[DNetCardListItem]>? = try await Network.sendThrow(request: request)
        return result?.result
    }

    struct Request: URLRequestProtocol {
        
        var url: URL {
            URL.baseAPI.appendingPathComponent("executor/my/card/list")
        }
        var body: Data? { nil }
        
        var method: HTTPMethod { .get }
    }
}

