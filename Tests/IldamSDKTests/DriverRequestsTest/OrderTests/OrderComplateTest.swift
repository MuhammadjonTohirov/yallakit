//
//  OrderComplateTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import XCTest
@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
@testable import IldamDriverSDK

final class OrderComplateTest : XCTestCase {
    func test_OrderComplateTest() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMDYyMTkyZDM3MWFhNDZkZGFhN2I4Zjc4OTNlMmRlN2YxYzEzNmY2YjZhN2Y2YWU2OTY3NjhhNTI0M2ZjYzFkMzcwNjcxNjAxNTQ1NDRhMzgiLCJpYXQiOjE3NDU2NDk0MDAuMjM4MjMzLCJuYmYiOjE3NDU2NDk0MDAuMjM4MjM0LCJleHAiOjE3NzcxODU0MDAuMjMxOTA5LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.RfnfeX9B3pWZ9hDNep228CJQoPAtg_PnNKfPFC4KDjzrhFHqnjIBwVcEwKYo3Re5xVksWEtb9oPi2lI1Lcxhrj_QTU3AjPCIBq7e5DD1o0slJFJUXqbg9-E0zMNYg9s3Aw8WW0lJHlEtZLzqr2g9bG08rPw_3t6wHqnBjUY_AUZqcqCt0HmWpSjcbgOpR_OJGD-xpyGK6MNBCuO5XOkMBfyZvyeJeRubfveDuaTQ0rMiq0zfT58ObNERaP4u5tqTh9IJc-r1huzijciGmpHu4Rl0IJsJz_3lzPhT_OthRWlPnrKmZTQ50c6SI1FgD1ZITwINMvl7lv8ZAxy14kUwblV3uBDfgyLO7X5e9YJWRPAr-yPZNAC8od2EpA7Xe8bM6HNmpJTeHJsvU2IQQiD4zWUCx6gkWXODSPSqFb7GwYyWnVJVFq-uJ5NqdmaDu1ZsAWwLp1B3YvnGGT6CD6IGVncIAFTypB5qEYfqnNKabaqjgvj57Yd0VzKoxgvRWGbjcsimFwXkVNXyXPyH-_t6xyvVOszCtkAlMHMeg6l2MDsPGPldvlGkBkrEoS07yAKYRedXq6bFIix1jzpxAMw2dnTJc7M33t9zGg3zWCY_LKzG3lxfkYuQYrAYw5QX_i51C6KDQPUEJJ-Z5C5pcH9WlGsMjyZrH18vUxD1FwmRU-w"
        
        let gateway = OrderComplateGateway()
        let tripBody = TripCalculationBody(
            taxiOrder: TaxiOrder(
                distance: 100,
                duration: "200",
                startPrice: 5000,
                remainderPrice: 2000,
                totalPrice: 6000,
                track: [
                    TripTrack(heading: 154, lat: 40.38387008942664, lng: 71.78324731998146, speed: 3.6, status: nil),
                    TripTrack(heading: 154, lat: 40.38387008942664, lng: 71.78324731998146, speed: 1.94, status: "appointed"),
                    TripTrack(heading: 154, lat: 40.38387008942664, lng: 71.78324731998146, speed: 1.94, status: "appointed"),
                    TripTrack(heading: 65.4, lat: 40.384053736925125, lng: 71.78315687924623, speed: 0.36, status: "appointed"),
                    TripTrack(heading: 65.4, lat: 40.384053736925125, lng: 71.78315687924623, speed: 0.41, status: "at_address"),
                    TripTrack(heading: 219.3, lat: 40.38395474664867, lng: 71.78310331888497, speed: 7.2, status: "at_address"),
                    TripTrack(heading: 219.3, lat: 40.38395474664867, lng: 71.78310331888497, speed: 2.6, status: "in_fetters"),
                    TripTrack(heading: 219.3, lat: 40.38395474664867, lng: 71.78310331888497, speed: 2.6, status: "completed")
                ],
                tripPrice: 8310,
                fullDuration: "0.13686666666666666",
                fullDistance: "0.03",
                totalMinutePrice: 8310,
                tripMinPrice: 8310,
                waitPrice: 8310,
                clientPayment: 8310,
                waitTime: "8310",
                inCity: TripZone(
                    distance: 300,
                    duration: "8310",
                    kmPrice: 20,
                    timePrice: 10,
                    waitPrice: 10,
                    waitTime: "8310"
                ),
                outCity: TripZone(
                    distance: 10,
                    duration: "20.00",
                    kmPrice: 30,
                    timePrice: 30,
                    waitPrice: 40,
                    waitTime: "50.00"
                )
            )
        )

        let result = try? await gateway.complateOrder(
            orderId: 1965815,
            body: tripBody)
        
        XCTAssertNotNil(
            result
        )
        
    }
}
