//
//  DeletePlaceGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/DeleteAddressGateway.swift
import Foundation
import NetworkLayer

protocol DeleteAddressGatewayProtocol: Sendable {
    func deleteAddress(id: Int) async -> Bool
}

struct DeleteAddressGateway: DeleteAddressGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func deleteAddress(id: Int) async -> Bool {
        let result: NetRes<Array<String>>? = await client.send(request: MainNetworkRoute.deleteAddress(id: id))
        return result?.success ?? false
    }
}
