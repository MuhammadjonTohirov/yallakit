//
//  DriverCreateCrubTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverCreateCrubTest: XCTestCase {
    func test_createOrderTest() async {
        
        let gateway = CreateCrubOrderGetway()
        let result = try? await gateway.create(lat: 40.37932798676815,lng: 71.78753480970809,tariffId: 130,name: "Humans")
        
 
        XCTAssertNotNil(result)
        
    }
}
