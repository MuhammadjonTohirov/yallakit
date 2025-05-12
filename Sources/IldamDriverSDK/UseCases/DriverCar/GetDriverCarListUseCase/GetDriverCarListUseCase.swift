//
//  d.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol GetDriverCarListUseCaseProtocol {
    func execute() async throws -> DriverCarListResponse
}

public final class GetDriverCarListUseCase: GetDriverCarListUseCaseProtocol {
    private var gateway: DriverCardListGatewayProtocol
    
    init(gateway: DriverCardListGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DriverCardListGateway()
    }
    
    public func execute() async throws -> DriverCarListResponse {
        
        guard let result = try? await gateway.fetchCardList() else {
            throw NSError(domain: "No car list found", code: -1)

        }
        return DriverCarListResponse(from: result)
    }
}
