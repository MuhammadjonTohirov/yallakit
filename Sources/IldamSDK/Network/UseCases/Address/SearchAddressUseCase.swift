//
//  SearchAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/SearchAddressUseCase.swift
import Foundation

public protocol SearchAddressUseCaseProtocol: Sendable {
    func execute(text: String) async -> [SearchAddressItem]
}

public struct SearchAddressUseCase: SearchAddressUseCaseProtocol, Sendable {
    private let gateway: SearchAddressGatewayProtocol

    public init() {
        self.gateway = SearchAddressGateway()
    }

    init(gateway: SearchAddressGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(text: String) async -> [SearchAddressItem] {
        guard let result = await gateway.searchAddress(text: text) else {
            return []
        }
        
        return result.map { SearchAddressItem(networkResponse: $0) }
    }
}
