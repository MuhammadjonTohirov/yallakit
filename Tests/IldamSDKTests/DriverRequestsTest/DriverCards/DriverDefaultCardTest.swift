
//
//  DriverDefaultCardTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverDefaultCardTest: XCTestCase {
    func test_verificationCode() async {
        
        let gateway = DriverDefaultCardGateway()
        let result = try? await gateway.getDefaultCard(cardId: "986019WRBYRT2401")
        
        XCTAssertNotNil(result)
        
    }
}
