//
//  GetMeInfoGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// GetMeInfoGateway.swift
import Foundation
import NetworkLayer

protocol GetMeInfoGatewayProtocol: Sendable {
    func getMeInfo() async -> NetResMeInfo?
}

struct GetMeInfoGateway: GetMeInfoGatewayProtocol {
    private let client: NetworkClientProtocol
    private var session: URLSession = .init(configuration: .default)

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getMeInfo() async -> NetResMeInfo? {
        await session.tasks.0.forEach({$0.cancel()})
        return (await client.send(urlSession: session, request: AuthNetworkRoute.getMeInfo))?.result
    }
}
