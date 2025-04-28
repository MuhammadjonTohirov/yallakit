//
//  DriverBuyPlanTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

import XCTest
@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
@testable import IldamDriverSDK

final class DriverBuyPlanTest: XCTestCase {
    func testExecute_getorderList() async {
        UserSettings.shared.accessToken = ""

        let getway = DriverBuyPlanGetWay()
        
        let res = try? await getway.buyPlan(planId: 54)
        XCTAssertNotNil(res != nil)

    }
}
