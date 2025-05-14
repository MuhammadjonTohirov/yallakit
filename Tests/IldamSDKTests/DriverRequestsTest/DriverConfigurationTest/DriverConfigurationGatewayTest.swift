//
//  DriverConfigurationGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//
import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverConfigurationGatewayTest: XCTestCase {
    func test_fetchCarList() async {
 
        let gateway = DriverConfigurationGateway()
        let result = try? await gateway.fetchConfig()
        
        XCTAssertNotNil(result)
        
    }
}

