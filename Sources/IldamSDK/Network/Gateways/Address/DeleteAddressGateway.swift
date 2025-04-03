//
//  DeletePlaceGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/DeleteAddressGateway.swift
import Foundation
import NetworkLayer

protocol DeleteAddressGatewayProtocol {
    func deleteAddress(id: Int) async -> Bool
}

struct DeleteAddressGateway: DeleteAddressGatewayProtocol {
    func deleteAddress(id: Int) async -> Bool {
        let result: NetRes<Array<String>>? = await Network.send(request: MainNetworkRoute.deleteAddress(id: id))
        return result?.success ?? false
    }
}
