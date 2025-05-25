//
//  DriverBrandListUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/05/25.
//

import Foundation

public protocol DriverBrandListUseCaseProtocol {
    func fetchBrandList() async throws -> [DriverBrandListResponse]

}
public final class DriverBrandListUseCase: DriverBrandListUseCaseProtocol {
    
    private var gateway: DriverOrderBrandGatewayProtocol
    
    init(gateway: DriverOrderBrandGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverOrderBrandGateway()
    }
    
    public func fetchBrandList() async throws -> [DriverBrandListResponse] {
        guard let result = try await gateway.fetchBrand() else {
            throw NSError(domain: "No brand list founded", code: -1)
        }
        return result.map { DriverBrandListResponse(from: $0) }

     }
    
}
