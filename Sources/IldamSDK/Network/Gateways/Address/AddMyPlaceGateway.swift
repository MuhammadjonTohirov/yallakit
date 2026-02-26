//
//  AddMyPlaceGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/AddPlaceGateway.swift
import Foundation
import NetworkLayer

protocol AddPlaceGatewayProtocol: Sendable {
    func addMyPlace(req: NetReqAddAddress) async -> Bool
}

struct AddPlaceGateway: AddPlaceGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func addMyPlace(req: NetReqAddAddress) async -> Bool {
        let result: NetRes<Array<String>>? = await client.send(request: MainNetworkRoute.addMyAddress(req: req))
        return result?.success ?? false
    }
}
