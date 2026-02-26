//
//  MyPlacesGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//


// Gateways/MyPlacesGateway.swift
import Foundation
import NetworkLayer

protocol MyPlacesGatewayProtocol: Sendable {
    func loadMyPlaces() async -> [NetResMyAddressItem]
}

struct MyPlacesGateway: MyPlacesGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func loadMyPlaces() async -> [NetResMyAddressItem] {
        let result: NetRes<[NetResMyAddressItem]>? = await client.send(request: MainNetworkRoute.getMyAddresses)
        return result?.result ?? []
    }
}
