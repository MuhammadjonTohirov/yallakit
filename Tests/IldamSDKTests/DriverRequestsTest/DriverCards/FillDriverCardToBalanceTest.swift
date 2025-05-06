//
//  FillDriverCardToBalanceTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class FillDriverCardToBalanceTest: XCTestCase {
    func test_verificationCode() async {
        
        let gateway = FillDriverCardToBalanceGateway()
        let result = try? await gateway.getDefaultCard(
            cardId: "986019WRBYRT2401",
            amount: 1)
        
        XCTAssertNotNil(result)
        
    }
}
