//
//  SendServiceTypeGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class SendServiceTypeGatewayTest: XCTestCase {

    func test_getTransport() async {
 
        let gateway = UpdateExecutorTariffOptionGateway()
        let result = try? await gateway.sendTariffOption(tariffId: [1,3])
        XCTAssertNotNil(result)
        
    }
}
