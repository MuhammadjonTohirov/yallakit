//
//  ExecutorOrderHistoryGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class ExecutorOrderHistoryGatewayTest: XCTestCase {
    func test_fetchTariff() async {
 
        let gateway = ExecutorOrderHistoryGateway()
        let result = try? await gateway.fetchOrderHistory(
            perPage: 25,
            date: "2025-04-03",
            type: "weekly",
            page: 1)
        
        XCTAssertNotNil(result)
        
    }
}

