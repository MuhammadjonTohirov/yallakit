//
//  DefaultTariffTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DefaultTariffTest: XCTestCase {
    func testGetDefaultTariff_success() async {
        UserSettings.shared.accessToken = ""
        
        let gateway = DefaultTariffGateway()
        let result = try? await gateway.getDefaultTariff()
        
        XCTAssertNotNil(result)
        
    }
}
