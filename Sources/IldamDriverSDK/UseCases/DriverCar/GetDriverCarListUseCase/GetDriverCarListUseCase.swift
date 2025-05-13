//
//  d.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol GetDriverCarListUseCaseProtocol {
    func execute() async throws -> [DriverCarListResponse]
}

public final class GetDriverCarListUseCase: GetDriverCarListUseCaseProtocol {
    private let gateway: DriverTransportListProtocol
    
    init(gateway: DriverTransportListProtocol) {
        self.gateway = gateway
    }
    public init() {
        self.gateway = DriverTransportListGateway()
    }
    
    public func execute() async throws -> [DriverCarListResponse] {
        let networkList = try await gateway.fetchCarList()
        
        return try networkList.map { try DriverCarListResponse(from: $0) }
    }
}
