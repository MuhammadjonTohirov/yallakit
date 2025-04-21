//
//  ReadAllNotifsUseCase.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 21/04/25.
//

import Foundation

public protocol ReadAllNotifsUseCaseProtocol {
    func execute() async throws -> Bool
}

public final class ReadAllNotifsUseCase: ReadAllNotifsUseCaseProtocol {
    private let gateway: ReadAllNotifsGateway
    
    init(gateway: ReadAllNotifsGateway = ReadAllNotifsGatewayImpl()) {
        self.gateway = gateway
    }
    
    public init() {
        gateway = ReadAllNotifsGatewayImpl()
    }
    
    public func execute() async throws -> Bool {
        try await gateway.execute()
    }
}
