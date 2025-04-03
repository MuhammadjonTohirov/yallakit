//
//  AddMyPlaceGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/AddPlaceGateway.swift
import Foundation
import NetworkLayer

protocol AddPlaceGatewayProtocol {
    func addMyPlace(req: NetReqAddAddress) async -> Bool
}

struct AddPlaceGateway: AddPlaceGatewayProtocol {
    func addMyPlace(req: NetReqAddAddress) async -> Bool {
        let result: NetRes<Array<String>>? = await Network.send(request: MainNetworkRoute.addMyAddress(req: req))
        return result?.success ?? false
    }
}
