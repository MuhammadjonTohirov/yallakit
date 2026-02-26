//
//  DeleteAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/DeleteAddressUseCase.swift
import Foundation

public protocol DeleteAddressUseCaseProtocol: Sendable {
    func execute(id: Int) async -> Bool
}

public struct DeleteAddressUseCase: DeleteAddressUseCaseProtocol, Sendable {
    private let gateway: DeleteAddressGatewayProtocol

    public init() {
        self.gateway = DeleteAddressGateway()
    }

    init(gateway: DeleteAddressGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute(id: Int) async -> Bool {
        return await gateway.deleteAddress(id: id)
    }
}
