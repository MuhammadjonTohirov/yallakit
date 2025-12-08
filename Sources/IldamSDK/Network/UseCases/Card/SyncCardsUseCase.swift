//
//  SyncCardsUseCase.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 28/01/25.
//

import Foundation
import UIKit
import Core

public protocol SyncCardsUseCase: Sendable {
    
}

public enum CardType {
    case humo
    case uzcard
    
    public var name: String {
        switch self {
        case .humo: return "Humo"
        case .uzcard: return "Uzcard"
        }
    }
    
    public var icon: UIImage? {
        switch self {
        case .humo: return UIImage(named: "humo_logo")
        case .uzcard: return UIImage(named: "uzcard_logo")
        }
    }
    
    public var iconName: String {
        switch self {
        case .humo: return "humo_logo"
        case .uzcard: return "uzcard_logo"
        }
    }
    
    public init(cardId: String) {
        self = cardId.count == 16 ? .humo : .uzcard
    }
}

public final class SyncCardsUseCaseImpl: @unchecked Sendable, SyncCardsUseCase {
    public var cards: [CardItem] = []
    
    public static let shared = SyncCardsUseCaseImpl()
    
    public var defaultCard: CardItem? {
        cards.first(where: {$0.isDefault ?? false})
    }
    
    public var paymentTypeString: String {
        defaultCard != nil ? (defaultCard?.miniPan ?? "") : "cash".localize
    }
    
    public func syncCards() async {
        cards = (try? await GetCardListUseCase().execute()) ?? []
    }
    
    public func setDefault(cardId: String) async {
        var _cards = cards
        guard let index = cards.firstIndex(where: {$0.cardId == cardId}) else {
            _ = try? await SetDefaultCardUseCase().execute(cardId: "cash")
            return
        }
        
        _cards[index].isDefault = true

        for i in 0..<_cards.count {
            _cards[i].isDefault = false
        }
        
        self.cards = _cards
        _ = try? await SetDefaultCardUseCase().execute(cardId: cardId)
    }
}

extension CardItem {
    public var type: CardType {
        .init(cardId: self.cardId ?? "cash")
    }
    
    public var miniPan: String {
        "**** " + self.maskedPan.suffix(4).description
    }
}
