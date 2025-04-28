//
//  DriverOrderTariffConfigTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverOrderTariffConfigTest: XCTestCase {
    func testExecute_sendOTP() async {
        UserSettings.shared.accessToken = ""
        let gateway = OrderTariffConfigurationGateway()
        let result = try? await gateway.getOrderTariffConfiguration(orderId: 1934508)
        
        XCTAssertTrue(result != nil)
    }
}
