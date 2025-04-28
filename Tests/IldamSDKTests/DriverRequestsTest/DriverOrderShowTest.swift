//
//  DriverOrderShowTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 25/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverOrderShowTest: XCTestCase {
    func testExecute_getorderShow() async {
        let gateway = DriverOrderShowGetway()
        
        let result = try? await gateway.getDriverOrderShow(orderId: 1934508)
        
        XCTAssertNotNil(result)
    }
}

