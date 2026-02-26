//
//  SearchAddressGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//


// Gateways/SearchAddressGateway.swift
import Foundation
import NetworkLayer
import Core

protocol SearchAddressGatewayProtocol: Sendable {
    func searchAddress(text: String) async -> [NetResAddressItem]?
}

struct SearchAddressGateway: SearchAddressGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func searchAddress(text: String) async -> [NetResAddressItem]? {
        guard let location = GLocationManager.shared.currentLocation?.coordinate else {
            return []
        }

        guard let result: NetRes<[NetResAddressItem]> = await client.send(request: MainNetworkRoute.searchAddress(
            text: text,
            lat: location.latitude.float,
            lng: location.longitude.float
        )) else {
            return nil
        }

        return result.success ? (result.result ?? []) : nil
    }
}
