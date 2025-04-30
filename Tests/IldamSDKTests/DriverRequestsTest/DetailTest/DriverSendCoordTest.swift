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
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMDYyMTkyZDM3MWFhNDZkZGFhN2I4Zjc4OTNlMmRlN2YxYzEzNmY2YjZhN2Y2YWU2OTY3NjhhNTI0M2ZjYzFkMzcwNjcxNjAxNTQ1NDRhMzgiLCJpYXQiOjE3NDU2NDk0MDAuMjM4MjMzLCJuYmYiOjE3NDU2NDk0MDAuMjM4MjM0LCJleHAiOjE3NzcxODU0MDAuMjMxOTA5LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.RfnfeX9B3pWZ9hDNep228CJQoPAtg_PnNKfPFC4KDjzrhFHqnjIBwVcEwKYo3Re5xVksWEtb9oPi2lI1Lcxhrj_QTU3AjPCIBq7e5DD1o0slJFJUXqbg9-E0zMNYg9s3Aw8WW0lJHlEtZLzqr2g9bG08rPw_3t6wHqnBjUY_AUZqcqCt0HmWpSjcbgOpR_OJGD-xpyGK6MNBCuO5XOkMBfyZvyeJeRubfveDuaTQ0rMiq0zfT58ObNERaP4u5tqTh9IJc-r1huzijciGmpHu4Rl0IJsJz_3lzPhT_OthRWlPnrKmZTQ50c6SI1FgD1ZITwINMvl7lv8ZAxy14kUwblV3uBDfgyLO7X5e9YJWRPAr-yPZNAC8od2EpA7Xe8bM6HNmpJTeHJsvU2IQQiD4zWUCx6gkWXODSPSqFb7GwYyWnVJVFq-uJ5NqdmaDu1ZsAWwLp1B3YvnGGT6CD6IGVncIAFTypB5qEYfqnNKabaqjgvj57Yd0VzKoxgvRWGbjcsimFwXkVNXyXPyH-_t6xyvVOszCtkAlMHMeg6l2MDsPGPldvlGkBkrEoS07yAKYRedXq6bFIix1jzpxAMw2dnTJc7M33t9zGg3zWCY_LKzG3lxfkYuQYrAYw5QX_i51C6KDQPUEJJ-Z5C5pcH9WlGsMjyZrH18vUxD1FwmRU-w"
        
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
