//
//  GetMeInfoGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 24/03/25.
//

// GetMeInfoGateway.swift
import Foundation
import NetworkLayer

protocol GetMeInfoGatewayProtocol {
    func getMeInfo() async -> NetResMeInfo?
}

struct GetMeInfoGateway: GetMeInfoGatewayProtocol {
    func getMeInfo() async -> NetResMeInfo? {
        return (await Network.send(request: AuthNetworkRoute.getMeInfo))?.result
    }
}
