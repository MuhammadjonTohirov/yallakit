//
//  CardNetworkService.swift
//  Ildam
//
//  Created by Sardorbek Saydamatov on 23/11/24.
//

// Services/CardService.swift
import Foundation
import Core

public protocol CardServiceProtocol {
    func addCard(request: CardAddRequest) async throws -> CardAddResponse?
    func verifyCard(request: CardVerifyRequest) async throws -> Bool
    func getCardList() async throws -> [CardItem]
    func setDefaultCard(cardId: String) async throws -> Bool
}

public final class CardService: CardServiceProtocol {
    
    private let addCardUseCase: AddCardUseCaseProtocol
    private let verifyCardUseCase: VerifyCardUseCaseProtocol
    private let getCardListUseCase: GetCardListUseCaseProtocol
    private let setDefaultCardUseCase: SetDefaultCardUseCaseProtocol
    
    public init(
        addCardUseCase: AddCardUseCaseProtocol = AddCardUseCase(),
        verifyCardUseCase: VerifyCardUseCaseProtocol = VerifyCardUseCase(),
        getCardListUseCase: GetCardListUseCaseProtocol = GetCardListUseCase(),
        setDefaultCardUseCase: SetDefaultCardUseCaseProtocol = SetDefaultCardUseCase()
    ) {
        self.addCardUseCase = addCardUseCase
        self.verifyCardUseCase = verifyCardUseCase
        self.getCardListUseCase = getCardListUseCase
        self.setDefaultCardUseCase = setDefaultCardUseCase
    }
    
    public func addCard(request: CardAddRequest) async throws -> CardAddResponse? {
        return try await addCardUseCase.execute(request: request)
    }
    
    public func verifyCard(request: CardVerifyRequest) async throws -> Bool {
        return try await verifyCardUseCase.execute(request: request)
    }
    
    public func getCardList() async throws -> [CardItem] {
        return try await getCardListUseCase.execute()
    }
    
    public func setDefaultCard(cardId: String) async throws -> Bool {
        return try await setDefaultCardUseCase.execute(cardId: cardId)
    }
}
