//
//  DriverGetOnlineTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverGetOnlineTest: XCTestCase {
    func test_getOnline() async {
 
        let gateway = DriverGetOnlineGateway()
        let result = try? await gateway.isDriverOnline()
        XCTAssertNotNil(result)
        
    }
}
