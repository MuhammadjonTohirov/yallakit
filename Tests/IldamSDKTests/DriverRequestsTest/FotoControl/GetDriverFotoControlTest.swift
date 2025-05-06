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

final class GetDriverFotoControlTest: XCTestCase {
    func testExecute_getPolygonList() async {
        let getway = GetDriverFotoControlGateway()
        
        do {
            let res = try await getway.getFotoControlShapes()
            XCTAssertNotNil(res)
            print("✅ Success:", res ?? "nil")
        } catch {
            XCTFail("❌ Error decoding: \(error)")
        }

    }
}
