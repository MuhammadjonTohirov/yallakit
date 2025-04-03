//
//  CardListGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/CardListGateway.swift
import Foundation
import NetworkLayer

protocol CardListGatewayProtocol {
    func getCardList() async throws -> [NetResCardItem]?
}

struct CardListGateway: CardListGatewayProtocol {
    func getCardList() async throws -> [NetResCardItem]? {
        let result: NetRes<[NetResCardItem]>? = try await Network.sendThrow(
            request: CardNetworkRouter.cardList
        )
        return result?.result
    }
}
