//
//  GetAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetAddressUseCase.swift
import Foundation

public protocol GetAddressUseCaseProtocol: Sendable {
    func execute(lat: Double, lng: Double) async -> AddressResponse?
}

public struct GetAddressUseCase: GetAddressUseCaseProtocol, Sendable {
    private let gateway: GetAddressGatewayProtocol

    public init() {
        self.gateway = GetAddressGateway()
    }

    init(gateway: GetAddressGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(lat: Double, lng: Double) async -> AddressResponse? {
        guard let result = await gateway.getAddress(lat: lat, lng: lng) else {
            return nil
        }
        
        return AddressResponse(response: result)
    }
}
