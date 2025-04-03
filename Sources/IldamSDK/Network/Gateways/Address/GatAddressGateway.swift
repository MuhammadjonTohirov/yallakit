//
//  GatAddressGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/GetAddressGateway.swift
import Foundation
import NetworkLayer

protocol GetAddressGatewayProtocol {
    func getAddress(lat: Double, lng: Double) async -> NetResGetAddress?
}

struct GetAddressGateway: GetAddressGatewayProtocol {
    func getAddress(lat: Double, lng: Double) async -> NetResGetAddress? {
        return (await Network.send(request: MainNetworkRoute.getAddress(lat: lat, lng: lng)))?.result
    }
}
