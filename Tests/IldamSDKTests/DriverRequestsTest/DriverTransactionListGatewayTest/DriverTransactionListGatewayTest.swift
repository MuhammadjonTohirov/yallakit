//
//  DriverTransactionListGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverTransactionListGatewayTest: XCTestCase {
    func test_fetchTariff() async {
        UserSettings.shared.accessToken = ""
        
        let gateway = FetchSecondaryAddressesUseCase()
        
        let result = try? await gateway.fetch(lat: 40.378157, lng: 71.777169)
        print("result: ", result?.balance ?? 0)
        XCTAssertNotNil(result)
    }
}


