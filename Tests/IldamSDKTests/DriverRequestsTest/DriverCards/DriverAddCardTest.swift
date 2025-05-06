//
//  DriverAddCardTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverAddCardTest: XCTestCase {
    func test_addCard() async {
 
        let gateway = DriverAddCardGateway()
        let result = try? await gateway.addCard(number: "9860190112392401", expiry: "0229")
        
        XCTAssertNotNil(result)
        
    }
}
