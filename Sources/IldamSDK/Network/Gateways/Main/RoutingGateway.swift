//
//  RoutingGateway.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 23/12/25.
//

import Foundation
import NetworkLayer
import Core

protocol RoutingGatewayProtocol: Sendable {
    func execute(
        req: [(lat: Double, lng: Double)]
    ) async throws -> RoutingResponse?
}

struct RoutingGateway: RoutingGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

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
        let res: NetRes<RoutingResponse>? = try await client.sendThrow(request: request)
        return res?.result
    }
}
