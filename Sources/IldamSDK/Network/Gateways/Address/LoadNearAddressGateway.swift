//
//  LoadNearAddressGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/LoadNearAddressGateway.swift
import Foundation
import NetworkLayer

protocol LoadNearAddressGatewayProtocol {
    func loadNearAddress(lat: Double, lng: Double) async -> [NetResAddressItem]
}

struct LoadNearAddressGateway: LoadNearAddressGatewayProtocol {
    func loadNearAddress(lat: Double, lng: Double) async -> [NetResAddressItem] {
        let result: NetRes<[NetResAddressItem]>? = await Network.send(request: MainNetworkRoute.getNearAddresses(lat: lat, lng: lng))
        return result?.result ?? []
    }
}
