//
//  PhotoControlUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol PhotoControlUseCaseProtocol {
    func getFotoControl() async throws -> [DriverFotoControlItem]
}

public final class PhotoControlUseCase: PhotoControlUseCaseProtocol {
    
    private var gateway: DriverFotoControlGatewayProtocol
    init(gateway: DriverFotoControlGatewayProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = GetDriverFotoControlGateway()
    }

    public func getFotoControl() async throws -> [DriverFotoControlItem] {
        guard let result = try? await gateway.getFotoControlShapes() else {
            throw NSError(domain: "No FotoControlShapes found", code: -1)
        }
        return result.map(DriverFotoControlItem.init)
    }
}
