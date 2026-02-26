//
//  GetAddressGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/GetAddressGateway.swift
import Foundation
import NetworkLayer

protocol GetAddressGatewayProtocol: Sendable {
    func getAddress(lat: Double, lng: Double) async -> NetResGetAddress?
}

struct GetAddressGateway: GetAddressGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getAddress(lat: Double, lng: Double) async -> NetResGetAddress? {
        return (await client.send(request: MainNetworkRoute.getAddress(lat: lat, lng: lng)))?.result
    }
}
