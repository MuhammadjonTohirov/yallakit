//
//  BrandServicesUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 05/02/26.
//

import Foundation

public protocol BrandServicesUseCaseProtocol: Sendable {
    func execute() async throws -> [BrandServiceItem]
}

public struct BrandServicesUseCase: BrandServicesUseCaseProtocol, Sendable {
    private let gateway: BrandServicesGatewayProtocol

    public init() {
        self.gateway = BrandServicesGateway()
    }

    init(gateway: BrandServicesGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> [BrandServiceItem] {
        let result = try await gateway.load()
        return result.map { BrandServiceItem(networkResponse: $0) }
    }
}
