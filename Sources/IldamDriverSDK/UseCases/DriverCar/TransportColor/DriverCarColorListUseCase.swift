//
//  TransportColorUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 17/05/25.
//

import Foundation

public protocol DriverCarColorListUseCaseProtocol {
    func execute() async throws -> [DriverColorList]
}

public final class DriverCarColorListUseCase: DriverCarColorListUseCaseProtocol {
    
    private let gateway: DriverCarColorListProtocol

    init(gateway: DriverCarColorListProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverCarColorListGateway()
    }
    public func execute() async throws -> [DriverColorList] {
        guard let result = try await gateway.fetchColors() else {
            throw NSError(domain: "No car colors found", code: -1)
        }

        return result.map { DriverColorList(from: $0) }
    }
}
