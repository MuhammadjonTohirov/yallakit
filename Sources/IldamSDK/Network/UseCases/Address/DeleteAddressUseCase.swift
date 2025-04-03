//
//  DeleteAddressUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/DeleteAddressUseCase.swift
import Foundation

public protocol DeleteAddressUseCaseProtocol {
    func execute(id: Int) async -> Bool
}

public final class DeleteAddressUseCase: DeleteAddressUseCaseProtocol {
    private let gateway: DeleteAddressGatewayProtocol
    
    init(gateway: DeleteAddressGatewayProtocol = DeleteAddressGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = DeleteAddressGateway()
    }
    
    public func execute(id: Int) async -> Bool {
        return await gateway.deleteAddress(id: id)
    }
}
