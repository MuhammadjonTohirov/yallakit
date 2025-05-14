//
//  DriverSendCoordTets.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverSendCoordTest: XCTestCase {
    func test_sendOnline() async {
        
        let gateway = DriverSendCoordGateway()
        let result = try? await gateway.sendCoords(coords:
            SendCoordsBody(
                coords: SendCoords(
                    heading: 360,
                    lat: 40.383702,
                    lng: 71.783059,
                    speed: 50,
                    orderStatus: "in_fetters",
                    orderId: nil,
                    online: true,
                    statusTime: "123231"
                ),
                orderCheck: OrderCheck(
                    coverPrice: 500,
                    accountCalculationStatus: false,
                    distance: 1.13,
                    duration: "0.29",
                    fullDistance: "2.09",
                    fullDuration: "6.8066",
                    inCity: DNetLocationZone(
                        distance: 1.13,
                        duration: "0.29",
                        waitPrice: 2891.4666666666662,
                        waitTime: "5.78"
                    ),
                    isWaitingTime: true,
                    outCity: DNetLocationZone(
                        distance: 0.0,
                        duration: "0.00",
                        waitPrice: 0.0,
                        waitTime: "0.00"
                    ),
                    remainderPrice: -151,
                    startPrice: 0,
                    totalMinutePrice: 0,
                    totalPrice: 5000,
                    tripPrice: 2260,
                    waitPrice: 2891,
                    waitTime: "5.78"
                )
            )
        )

        XCTAssertNotNil(result)
                                                   
    }
}
