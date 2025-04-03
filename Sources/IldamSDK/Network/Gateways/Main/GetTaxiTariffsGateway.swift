//
//  GetTariffsGateway.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// Gateways/GetTaxiTariffsGateway.swift
import Foundation
import NetworkLayer

protocol GetTaxiTariffsGatewayProtocol {
    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> NetResTaxiTariffList?
}

struct GetTaxiTariffsGateway: GetTaxiTariffsGatewayProtocol {
    func getTaxiTariffs(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> NetResTaxiTariffList? {
        let result: NetRes<NetResTaxiTariffList>? = await Network.send(
            request: MainNetworkRoute.getTariffs(
                req: .init(coords: coords, options: options, addressId: addressId)
            )
        )
        return result?.result
    }
}
