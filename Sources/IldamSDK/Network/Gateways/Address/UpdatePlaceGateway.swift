//
//  UpdatePlaceGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/UpdatePlaceGateway.swift
import Foundation
import NetworkLayer

protocol UpdatePlaceGatewayProtocol {
    func updateMyPlace(req: NetReqEditAddress, id: Int) async -> Bool
}

struct UpdatePlaceGateway: UpdatePlaceGatewayProtocol {
    func updateMyPlace(req: NetReqEditAddress, id: Int) async -> Bool {
        let result: NetRes<Array<String>>? = await Network.send(request: MainNetworkRoute.updateMyAddress(req: req, id: id))
        return result?.success ?? false
    }
}
