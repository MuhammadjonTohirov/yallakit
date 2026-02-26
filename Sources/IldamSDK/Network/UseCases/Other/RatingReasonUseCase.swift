//
//  RatingReasonUseCase.swift
//  IldamSDK
//
//  Created by applebro on 06/02/26.
//

import Foundation

public protocol RatingReasonUseCaseProtocol: Sendable {
    func execute() async throws -> [RatingReasonItem]
}

public struct RatingReasonUseCase: RatingReasonUseCaseProtocol, Sendable {
    private let gateway: RatingReasonGatewayProtocol

    public init() {
        self.gateway = RatingReasonGateway()
    }

    init(gateway: RatingReasonGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> [RatingReasonItem] {
        return try await gateway.load().compactMap { item in
            guard let id = item.id,
                  let name = item.name,
                  let rating = item.rating else {
                return nil
            }
            return RatingReasonItem(id: id, name: name, rating: rating, icon: item.icon)
        }
    }
}
