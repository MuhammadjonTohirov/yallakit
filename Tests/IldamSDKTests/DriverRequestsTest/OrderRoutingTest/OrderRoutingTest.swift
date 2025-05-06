//
//  GetLocationNameTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class OrderRoutingTest: XCTestCase {
    func testExecute_orderRouting() async {
        
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMDYyMTkyZDM3MWFhNDZkZGFhN2I4Zjc4OTNlMmRlN2YxYzEzNmY2YjZhN2Y2YWU2OTY3NjhhNTI0M2ZjYzFkMzcwNjcxNjAxNTQ1NDRhMzgiLCJpYXQiOjE3NDU2NDk0MDAuMjM4MjMzLCJuYmYiOjE3NDU2NDk0MDAuMjM4MjM0LCJleHAiOjE3NzcxODU0MDAuMjMxOTA5LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.RfnfeX9B3pWZ9hDNep228CJQoPAtg_PnNKfPFC4KDjzrhFHqnjIBwVcEwKYo3Re5xVksWEtb9oPi2lI1Lcxhrj_QTU3AjPCIBq7e5DD1o0slJFJUXqbg9-E0zMNYg9s3Aw8WW0lJHlEtZLzqr2g9bG08rPw_3t6wHqnBjUY_AUZqcqCt0HmWpSjcbgOpR_OJGD-xpyGK6MNBCuO5XOkMBfyZvyeJeRubfveDuaTQ0rMiq0zfT58ObNERaP4u5tqTh9IJc-r1huzijciGmpHu4Rl0IJsJz_3lzPhT_OthRWlPnrKmZTQ50c6SI1FgD1ZITwINMvl7lv8ZAxy14kUwblV3uBDfgyLO7X5e9YJWRPAr-yPZNAC8od2EpA7Xe8bM6HNmpJTeHJsvU2IQQiD4zWUCx6gkWXODSPSqFb7GwYyWnVJVFq-uJ5NqdmaDu1ZsAWwLp1B3YvnGGT6CD6IGVncIAFTypB5qEYfqnNKabaqjgvj57Yd0VzKoxgvRWGbjcsimFwXkVNXyXPyH-_t6xyvVOszCtkAlMHMeg6l2MDsPGPldvlGkBkrEoS07yAKYRedXq6bFIix1jzpxAMw2dnTJc7M33t9zGg3zWCY_LKzG3lxfkYuQYrAYw5QX_i51C6KDQPUEJJ-Z5C5pcH9WlGsMjyZrH18vUxD1FwmRU-w"
        
        let getway = OrderRoutingCoordsGateway()
        
        let res = try? await getway.calculateRoute(points: [
            DNetOrderRoutingPoint(lat: 40.383702, lng: 71.783059),
            DNetOrderRoutingPoint(lat: 40.3846498, lng: 71.780979)
        ])

        XCTAssertNotNil(res)
    }
}
