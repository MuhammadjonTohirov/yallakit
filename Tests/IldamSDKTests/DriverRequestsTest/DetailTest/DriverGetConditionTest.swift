//
//  dsa.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverGetConditionTest: XCTestCase {
    func test_getCondition() async {
        
        let gateway = DriverGetConditionGateway()
        let result = try? await gateway.getCondition()
        XCTAssertNotNil(result)
        
    }
}
