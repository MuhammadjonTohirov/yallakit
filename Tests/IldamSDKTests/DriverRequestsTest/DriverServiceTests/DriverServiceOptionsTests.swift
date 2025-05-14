//
//  DriverServiceTests.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverServiceOptionsTests: XCTestCase {
    func test_getTransport() async {
 
        let gateway = GetExecutorTariffOptionGateway()
        let result = try? await gateway.fetchServiceOptions()
        XCTAssertNotNil(result)
        
    }
}
