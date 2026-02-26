//
//  AddCardGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/AddCardGateway.swift
import Foundation
import NetworkLayer

protocol AddCardGatewayProtocol: Sendable {
    func addCard(cardNumber: String, expiry: String) async throws -> NetResAddCard?
}

struct AddCardGateway: AddCardGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func addCard(cardNumber: String, expiry: String) async throws -> NetResAddCard? {
        let result: NetRes<NetResAddCard>? = try await client.sendThrow(
            request: CardNetworkRouter.addCard(number: cardNumber, expiry: expiry)
        )
        return result?.result
    }
}
