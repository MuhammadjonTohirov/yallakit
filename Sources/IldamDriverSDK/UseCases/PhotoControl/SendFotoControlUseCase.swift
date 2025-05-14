//
//  SendFotoControlUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 12/05/25.
//

import Foundation

public protocol SendFotoControlUseCaseProtocol {
    func sendDriverCarPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool
}

public final class SendFotoControlUseCase: SendFotoControlUseCaseProtocol {
    private var gateway: SendFotoControlGatewayProtocol
    
    init(gateway: SendFotoControlGatewayProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = SendFotoControlGateway()
    }
    
    public func sendDriverCarPhotos(body: [SendFotoControlBodyItem]) async throws -> Bool {
        let result = try await gateway.sendPhotos(body: body)
        
        if result == false {
            throw NSError(domain: "Sending DriverCarPhotos failed", code: -1)
        }
        
        return result
    }
}
