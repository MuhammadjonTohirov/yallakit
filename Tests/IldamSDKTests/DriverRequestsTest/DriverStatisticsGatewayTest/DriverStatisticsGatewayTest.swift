//
//  DriverStatisticsGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverStatisticsGatewayTest: XCTestCase {
    func test_fetchTariff() async {
 
        let gateway = DriverStatisticsGateway()
        let result = try? await gateway.fetchStatistics(type: "daily")
        
        XCTAssertNotNil(result)
        
    }
}

