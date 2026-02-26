//
//  SelectDefaultCardGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/SelectDefaultCardGateway.swift
import Foundation
import NetworkLayer

protocol SelectDefaultCardGatewayProtocol: Sendable {
    func selectDefaultCard(cardId: String) async throws -> Bool
}

struct SelectDefaultCardGateway: SelectDefaultCardGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func selectDefaultCard(cardId: String) async throws -> Bool {
        let result: NetRes<String>? = try await client.sendThrow(
            request: CardNetworkRouter.selectDefaultCard(id: cardId)
        )
        return result?.success ?? false
    }
}
