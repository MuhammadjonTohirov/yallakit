//
//  UpdateClassTariffClassUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli on 13/05/25.
// protocol UpdateExecutorTariffClassProtocol {
//func sendTariffOption(tariffClassIDs: [Int]) async throws -> Bool?
//}
//
import Foundation

public protocol UpdateClassTariffClassUseCaseProtocol {
    func sendTariffClass(tariffClassIDs: [Int]) async throws -> Bool?
}

public final class UpdateClassTariffClassUseCase: UpdateClassTariffClassUseCaseProtocol {
    
    private var gateway: UpdateExecutorTariffClassProtocol
    
    init(gateway: UpdateExecutorTariffClassProtocol) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = UpdateExecutorTariffClassGateway()
    }
    
    public func sendTariffClass(tariffClassIDs: [Int]) async throws -> Bool? {
        return try await gateway.sendTariffOption(tariffClassIDs: tariffClassIDs)
    }
}


