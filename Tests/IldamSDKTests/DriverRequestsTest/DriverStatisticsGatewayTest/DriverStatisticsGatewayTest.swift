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
        
        UserSettings.shared.accessToken = ""
        
        let gateway = DriverStatisticsUseCase()
        let result = try? await gateway.fetchStatistics(type: "daily")
        
        print("result: ", result?.allBonus)
        XCTAssertNotNil(result)
        
    }
}

