//
//  GetAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetAddressUseCase.swift
import Foundation

public protocol GetAddressUseCaseProtocol {
    func execute(lat: Double, lng: Double) async -> AddressResponse?
}

public final class GetAddressUseCase: GetAddressUseCaseProtocol {
    private let gateway: GetAddressGatewayProtocol
    
    init(gateway: GetAddressGatewayProtocol = GetAddressGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = GetAddressGateway()
    }
    
    public func execute(lat: Double, lng: Double) async -> AddressResponse? {
        guard let result = await gateway.getAddress(lat: lat, lng: lng) else {
            return nil
        }
        
        var response = AddressResponse(response: result)
        response?.lat = lat
        response?.lng = lng
        return response
    }
}
