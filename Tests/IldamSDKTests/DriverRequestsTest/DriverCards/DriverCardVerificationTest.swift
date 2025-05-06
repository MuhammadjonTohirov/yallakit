//
//  DriverCardVerificationTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//
//DriverCardVerificationGateway
import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverCardVerificationTest: XCTestCase {
    func test_verificationCode() async {
 
        let gateway = DriverCardVerificationGateway()
        let result = try? await gateway.sendCode(key: "96e751b6-2e31-4ec2-ac18-3aacbd6b42db", confirm_code: "367546")
        
        XCTAssertNotNil(result)
        
    }
}
