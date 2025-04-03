//
//  SelectDefaultCardGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/SelectDefaultCardGateway.swift
import Foundation
import NetworkLayer

protocol SelectDefaultCardGatewayProtocol {
    func selectDefaultCard(cardId: String) async throws -> Bool
}

struct SelectDefaultCardGateway: SelectDefaultCardGatewayProtocol {
    func selectDefaultCard(cardId: String) async throws -> Bool {
        let result: NetRes<String>? = try await Network.sendThrow(
            request: CardNetworkRouter.selectDefaultCard(id: cardId)
        )
        return result?.success ?? false
    }
}
