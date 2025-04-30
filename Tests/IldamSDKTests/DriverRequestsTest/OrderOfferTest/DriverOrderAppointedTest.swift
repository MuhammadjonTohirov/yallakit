//
//  DriverCreateCrubTest 2.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//


import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverOrderAppointedTest: XCTestCase {
    func test_getAppointedOrderTest() async {
        UserSettings.shared.accessToken = ""
        
        let gateway = GetAppointedOrderGateway()
        let result = try? await gateway.getAppointedOrder(orderId: 1962990)
        
        XCTAssertNotNil(result)
        
    }
}
