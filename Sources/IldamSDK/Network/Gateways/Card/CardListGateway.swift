//
//  CardListGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/CardListGateway.swift
import Foundation
import NetworkLayer

protocol CardListGatewayProtocol: Sendable {
    func getCardList() async throws -> [NetResCardItem]?
}

struct CardListGateway: CardListGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getCardList() async throws -> [NetResCardItem]? {
        let result: NetRes<[NetResCardItem]>? = try await client.sendThrow(
            request: CardNetworkRouter.cardList
        )
        return result?.result
    }
}
