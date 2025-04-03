//
//  SearchAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/SearchAddressUseCase.swift
import Foundation

public protocol SearchAddressUseCaseProtocol {
    func execute(text: String) async -> [SearchAddressItem]
}

public final class SearchAddressUseCase: SearchAddressUseCaseProtocol {
    private let gateway: SearchAddressGatewayProtocol
    
    init(gateway: SearchAddressGatewayProtocol = SearchAddressGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = SearchAddressGateway()
    }
    
    public func execute(text: String) async -> [SearchAddressItem] {
        guard let result = await gateway.searchAddress(text: text) else {
            return []
        }
        
        return result.map { SearchAddressItem(networkResponse: $0) }
    }
}
