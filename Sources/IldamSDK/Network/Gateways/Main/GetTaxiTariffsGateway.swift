//
//  GetTariffsGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/GetTaxiTariffsGateway.swift
import Foundation
import NetworkLayer

protocol GetTaxiTariffsGatewayProtocol: Sendable {
    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> NetResTaxiTariffList?
}

struct GetTaxiTariffsGateway: GetTaxiTariffsGatewayProtocol {
    private let client: NetworkClientProtocol

    init(client: NetworkClientProtocol = DefaultNetworkClient()) {
        self.client = client
    }

    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> NetResTaxiTariffList? {
        let result: NetRes<NetResTaxiTariffList>? = await client.send(
            request: MainNetworkRoute.getTariffs(
                req: .init(coords: coords, options: options, addressId: addressId)
            )
        )
        return result?.result
    }
}
