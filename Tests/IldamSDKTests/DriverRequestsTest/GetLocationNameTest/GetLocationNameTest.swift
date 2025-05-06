//
//  SendDriverPhotoFontrollerTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class GetLocationNameTest: XCTestCase {
    func testExecute_getPolygonList() async {

        let getway = GetLocationNameGateway()
        
        let res = try? await getway.fetchLocationName(lat: 40.38417098112138, lng: 71.79065417761898)
        
        XCTAssertNotNil(res)
    }
}
