//
//  DriverPlanListsTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverPlanListsTest: XCTestCase {
    func testExecute_getPlanLists() async {
        
        let gateway = DriverPlanListGatewayGetway()
        let result = try? await gateway.getPlanLists()
        
        XCTAssertNotNil(result)
    }
}
