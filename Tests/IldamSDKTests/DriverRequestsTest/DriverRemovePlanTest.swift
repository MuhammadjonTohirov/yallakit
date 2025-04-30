//
//  DriverRemovePlanTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverRemovePlanTest: XCTestCase {
    func testExecute_getPlanShow() async {
        UserSettings.shared.accessToken = ""
    
        let gateway = DriverRemovePlanGetway()
        let result = try? await gateway.removePlan(planId: 4)
        
        XCTAssertNotNil(result)
    }
}
