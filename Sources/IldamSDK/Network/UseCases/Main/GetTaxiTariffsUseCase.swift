//
//  GetTaxiTariffsUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetTaxiTariffsUseCase.swift
import Foundation

public protocol GetTaxiTariffsUseCaseProtocol: Sendable {
    func execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> [TaxiTariff]
}

public struct GetTaxiTariffsUseCase: GetTaxiTariffsUseCaseProtocol, Sendable {
    private let gateway: GetTaxiTariffsGatewayProtocol

    public init() {
        self.gateway = GetTaxiTariffsGateway()
    }

    init(gateway: GetTaxiTariffsGatewayProtocol) {
        self.gateway = gateway
    }

    public func execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> [TaxiTariff] {
        guard let result = await gateway.getTaxiTariffs(coords: coords, addressId: addressId, options: options) else {
            return []
        }
        
        return TaxiTariffList(res: result)?.tariffs ?? []
    }
}
