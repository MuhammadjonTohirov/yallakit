//
//  DriiverOrderBrandTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriiverOrderBrandTest: XCTestCase {
    func test_getBrands() async {
 
        let gateway = DriverOrderBrandGateway()
        let result = try? await gateway.fetchBrand()
        XCTAssertNotNil(result)
        
    }
}
