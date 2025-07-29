//
//  CardListUseCase.swift
//  IldamSDK
//
//  Created by Muhammadjon Tohirov on 25/03/25.
//

// UseCases/GetCardListUseCase.swift
import Foundation
import Core

public protocol GetCardListUseCaseProtocol {
    func execute() async throws -> [CardItem]
}

public final class GetCardListUseCase: GetCardListUseCaseProtocol {
    private let gateway: CardListGatewayProtocol
    
    init(gateway: CardListGatewayProtocol = CardListGateway()) {
        self.gateway = gateway
    }
    
    public init() {
        self.gateway = CardListGateway()
    }
    
    public func execute() async throws -> [CardItem] {
        let result = try await gateway.getCardList()
        return result?.map { CardItem(res: $0) } ?? []
    }
}

extension CardItem {
    convenience init(res: NetResCardItem) {
        self.init(
            cardId: res.cardId,
            isDefault: res.isDefault,
            expiry: res.expiry,
            maskedPan: res.maskedPan ?? "",
            createdAt: res.createdAt
        )
    }
}
