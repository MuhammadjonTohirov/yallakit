//
//  AuthMeTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 03/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverLogOutTest: XCTestCase {
    func test_fetchColor() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiZGEyMjhlYjAwMTJmOWJiNDNiMjFlYzdhM2IyMzU4M2ZhYzlmOGU5MDY1YThlNDNmNzI0Njc1ZTU1MGM1ZDI1OTA0Y2YwN2Y5MjlmNDhjMDMiLCJpYXQiOjE3NDYyNDg5MTQuNjA1OTIzLCJuYmYiOjE3NDYyNDg5MTQuNjA1OTI0LCJleHAiOjE3Nzc3ODQ5MTQuNTk5MTU3LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.F_ku_U5Q_ycQFjV1GItvoEOU0SJhvjaJqZvI9v5hzmmYHmaVyg6-D49LZQuiQczQGfGXLc3L4VRCTeuU8N_fFKduB7bJfSKcU_9XEEmZoc-47QQbik0r95BqIuqRpZ60ibXcYwDMGbo-o_BmnlSeXusO1jgqAAGVXpn-mdGQClwpWxHQ-_7gvBwQ_-izG2UQS7DohM_dZIsd1yPgRI7SJyehiLlLHg_PEm0voPVrC40Z1AQUl-yOh8jN5IHc0IWiX5RT15-1nb3CWYhgr2j-y310O77VwZgimmDqxHU_C2LueBicLCLvmX4bKIvXtmRbwnmEpb-DvSjJdy6rGi1j92R-VYFuAZLenWa3j39wt2kKipsVH7sdulDOZOJoBANzRvd6_V3nfy-BVe2J17t0KRCuSnj1bWz6qc4cenTYNgnWdc4uf1D3B2xymT1VNBzEh6YXvGfkUrwKIiIoJXvJwmixkl2u8qAEn3FZZzJAvs62CvLME2eKiwWX1caPPetxWgKaDp8qaJtQwBhcngO10DgDD0IJRRu60RtdoyfqdYK87_c8oUDLmiiRaQVXLR-3tFwjxf2mcwcRUSTxcn3cEXhVqF4dCusIdnT5uwMuZPlhh-ba6B1svzNpHecoJ-D9q9Jc_-EC6ARM2Vw6o8AAEZKMbhqJb-QYGB2jgbH4MOA"
        
        let gateway = DriverLogOutGateway()
        let result = try? await gateway.logut()
        XCTAssertNotNil(result)
        
    }
}
