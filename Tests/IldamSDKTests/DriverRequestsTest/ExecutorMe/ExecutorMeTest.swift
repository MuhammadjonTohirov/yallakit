//
//  GetDriverFotoControlTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//


@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class ExecutorMeTest: XCTestCase {
    func testExecute_getExecutorMe() async {
        let getway = ExecutorMeGateway()
        
        
        let res = try? await getway.getExecutorMe()
        print("Balance: ", res?.balance ?? 0)
        XCTAssertNotNil(res?.balance != nil)
     }
}
