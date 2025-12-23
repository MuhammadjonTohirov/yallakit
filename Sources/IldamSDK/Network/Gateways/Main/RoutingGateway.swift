//
//  RoutingGateway.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 23/12/25.
//

import Foundation
import NetworkLayer
import Core

protocol RoutingGatewayProtocol {
    func execute(
        req: [(lat: Double, lng: Double)]
    ) async throws -> RoutingResponse?
}

final class RoutingGateway: RoutingGatewayProtocol {
    private lazy var session: URLSession = URLSession(configuration: .default)
    
    func execute(req: [(lat: Double, lng: Double)]) async throws -> RoutingResponse? {
        let reqCount = req.count
        let points: [RoutingRequest.RoutingPoint] = req.enumerated().map { (index, item) in
            let isLast = index == reqCount - 1
            
            return .init(
                type: index == 0 ? .start : (isLast ? .stop : .point),
                lng: item.lng,
                lat: item.lat
            )
        }
        
        let request = RoutingRequest(points: points)
        let res: NetRes<RoutingResponse>? = try await Network.sendThrow(request: request)
        return res?.result
    }
}
