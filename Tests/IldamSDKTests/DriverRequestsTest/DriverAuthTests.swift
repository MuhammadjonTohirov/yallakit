//
//  File.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverAuthTests: XCTestCase {
    func testExecute_sendOTP() async {
        let gateway = DSendOTPGateway()
        let result = try? await gateway.send(phone: "998889979723")
        XCTAssertTrue(result != nil)
    }
}
