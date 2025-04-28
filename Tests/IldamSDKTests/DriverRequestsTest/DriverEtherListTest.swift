//
//  DriverEtherListTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverEtherListTest: XCTestCase {
    func testExecute_getorderList() async {
        UserSettings.shared.accessToken = ""

        let getway = EtherListGetway()
        
        let res = try? await getway.getEtherList(type: "ether")
        XCTAssertNotNil(res != nil)

    }
}
