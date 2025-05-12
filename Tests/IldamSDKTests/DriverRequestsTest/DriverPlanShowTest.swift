//
//  DriverPlanShow.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverPlanShowTest: XCTestCase {
func testExecute_getPlanShow() async {
        let gateway = DriverPlanShowGateway()
        let result = try? await gateway.getPlanShow(planId: 4)
        
        XCTAssertNotNil(result)
    }
}
