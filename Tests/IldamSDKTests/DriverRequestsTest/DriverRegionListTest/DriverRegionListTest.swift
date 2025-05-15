//
//  DriverRegionListTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 15/05/25.
//

import Foundation

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverRegionListTest: XCTestCase {
    func test_getBrands() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMjMyYThhNGIwMjZiZTJhMWQ2MmFkNmZkYjIyMDU5NTc0MjIxNzVkOGNhMjc1MjAwZjY4ODBiOTU0YzYzZGJmNTg5NDdhYmU2MGIxM2QzZTAiLCJpYXQiOjE3NDcxMjQ0NDIuMzMyMDY1LCJuYmYiOjE3NDcxMjQ0NDIuMzMyMDY2LCJleHAiOjE3Nzg2NjA0NDIuMzIzOTY3LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.ul0vOdfAxgx_8pvHP3NA-LnPYa2v5bqk32sRhKEdzMCR9LeezX0YbSu3jJMzhJRmoqByvxzNhY7-BuckGndu8JJwCLnuChLCPvtArXFuHnEhUVZuckdIQGmdHSPTTN2955_J6pdvHXjoe2HjsqIg30GLadgN1HPJNrI8FtGznoCSEkp0-vZpLu6rAzmikHeLBWmW9rPT5Thn4Axb1QkhR9cPD0J5NvkB0iYNdboyS-54iMTbOHhu3UaPlcpb60co-jb8e1wgF8lROaOhNmi5vc7r8Nq3jN-jecSh28oAmeBT16sB6Bt6JL6IHO0ixZH8-OcHR4XBWOoJUYc9-iVSjdluBKlIosAV_q39MoDVYLHtDsw8Y-70x0D_8_23SrCisHzC29RF428aI90qvHyL26i1KupEiul66xjf3wsgrrrUzdBpLvv1nLNO6ktigSrgndPbaUM7vxc9YujE-kGZ33TJLz2NO_0z1mVwWLbOW658qjaaF5sCyaHgIFK23feYzf6WNeZAtapTlcd6HRRRm1SLvqZNYH6IG4rYcQ4hhUwlMHN0LDkQg8L97rdypxpy8wG5bVtsrgAO5zbmhDpqNcsvmSEM5DERmsuTwqBZnQ9EthRB85E7Cbvi8yxaXnI1vWUfyFZG4Y58ojh8PJ7g-B5L4S1X-u17Qs1veqJozuo"
        let gateway = RegionListGateway()
        let result = try? await gateway.fetchRegions()
        XCTAssertNotNil(result)
        
    }
}

