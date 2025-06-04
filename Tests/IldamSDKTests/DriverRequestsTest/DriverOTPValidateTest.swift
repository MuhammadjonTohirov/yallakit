//
//  DriverOTPValidateTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 24/04/25.
//

import XCTest
@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
@testable import IldamDriverSDK

final class DriverOTPValidateTest: XCTestCase {
    func testExecute_sendOTP() async {
        let gateway = DCheckOTPGateway()
        let result = try? await gateway.send(code: "23035")
        
        print(result)
        
        XCTAssertNotNil(result)
    }
}
