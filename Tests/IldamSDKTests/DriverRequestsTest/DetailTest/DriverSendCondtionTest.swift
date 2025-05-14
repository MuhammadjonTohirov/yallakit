//
//  DriverSendCondtionTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverSendCondtionTest: XCTestCase {
    func test_sendOnline() async {
        let gateway = DriverSendConditionGateway()
        let result = try? await gateway.sendCondtion()
        XCTAssertNotNil(result)
        
    }
}
