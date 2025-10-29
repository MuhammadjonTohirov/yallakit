//
//  ActivateBonuseUseCase.swift
//  YallaKit
//
//  Created by MuhammadAli Yo'lbarsbekov on 29/10/25.
//

import Foundation
import SwiftUI

public protocol ActivateBonuseUseCaseProtocol {
    func activate(promoCode: String) async throws -> ActivatePromocodeResult?
}

public struct ActivateBonuseUseCase: ActivateBonuseUseCaseProtocol {
    public init() {
    }
    
    public func activate(promoCode: String) async throws -> ActivatePromocodeResult? {
        guard let result = try await ActivateBonuseGateway().activate(promoCode: promoCode) else {
            return nil
        }
        
        return .init(value: result.amount, message: result.message)
    }
}
