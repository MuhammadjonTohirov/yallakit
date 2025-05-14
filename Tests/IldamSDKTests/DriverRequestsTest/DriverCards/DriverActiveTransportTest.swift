//
//  DriverActiveTransportTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverActiveTransportTest: XCTestCase {
    func test_sendActiveCarID() async {
 
        let gateway = DriverActiveTransportGateway()
        let result = try? await gateway.sendTransportId(id: 12787)
        
        XCTAssertNotNil(result)
        
    }
}
