//
//  ExecutorOrderShowHistoryGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverFirebaseTookenGatewayTest: XCTestCase {
    func test_sendTooken() async {
 
        let gateway = DriverFirebaseTookenGateway()
        let result = try? await gateway.sendTooken(tooken: "e3WDVaCD5zzIUGDjpi4jFY:APA91bE3fIWxWQAyGOXZbsulaId7fzkXXUvRk7ld8c6JoEvZiKRdhPNOGuxFXUEHxd0DCBsOu0BigBE3zV2K61MY7FP62FF7jduV33rPFEQr9XT9Rhbz-7frHA5vqlyE7zheOFaZi6qw")
        XCTAssertNotNil(result)
        
    }
}

