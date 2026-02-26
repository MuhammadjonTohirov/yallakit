//
//  CardListUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetCardListUseCase.swift
import Foundation
import Core

public protocol GetCardListUseCaseProtocol: Sendable {
    func execute() async throws -> [CardItem]
}

public struct GetCardListUseCase: GetCardListUseCaseProtocol, Sendable {
    private let gateway: CardListGatewayProtocol

    public init() {
        self.gateway = CardListGateway()
    }

    init(gateway: CardListGatewayProtocol) {
        self.gateway = gateway
    }
    
    public func execute() async throws -> [CardItem] {
        let result = try await gateway.getCardList()
        return result?.map { CardItem(res: $0) } ?? []
    }
}

extension CardItem {
    init(res: NetResCardItem) {
        self.init(
            cardId: res.cardId,
            isDefault: res.isDefault,
            expiry: res.expiry,
            maskedPan: res.maskedPan ?? "",
            createdAt: res.createdAt
        )
    }
}
