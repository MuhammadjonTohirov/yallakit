//
//  GetTaxiTariffsUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetTaxiTariffsUseCase.swift
import Foundation

public protocol GetTaxiTariffsUseCaseProtocol {
    func execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> [TaxiTariff]
}

public final class GetTaxiTariffsUseCase: GetTaxiTariffsUseCaseProtocol {
    private let gateway: GetTaxiTariffsGatewayProtocol
    
    init(gateway: GetTaxiTariffsGatewayProtocol = GetTaxiTariffsGateway()) {
        self.gateway = gateway
    }
    
    public func execute(coords: [(lat: Double, lng: Double)], addressId: Int, options: [Int]) async -> [TaxiTariff] {
        guard let result = await gateway.getTaxiTariffs(coords: coords, addressId: addressId, options: options) else {
            return []
        }
        
        return TaxiTariffList(res: result)?.tariffs ?? []
    }
}
