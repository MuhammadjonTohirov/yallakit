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
    private var session: URLSession = .init(configuration: .default)
    
    func getMeInfo() async -> NetResMeInfo? {
        await session.tasks.0.forEach({$0.cancel()})
        return (await Network.send(urlSession: session, request: AuthNetworkRoute.getMeInfo))?.result
    }
}
