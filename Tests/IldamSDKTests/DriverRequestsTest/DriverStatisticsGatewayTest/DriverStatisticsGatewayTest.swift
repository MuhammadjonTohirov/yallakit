//
//  DriverStatisticsGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 07/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverStatisticsGatewayTest: XCTestCase {
    func test_fetchTariff() async {
        
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiOGQzMDNkNjFmZjJmOGExM2RmOWYxYmIwYTYyM2I4NWNhZTE2YjM1MGIzNTM1OTg1OGVjZmEwNzQ1MzNmNjUwZDUyYmEzYjVjNjE3ODQ4YWYiLCJpYXQiOjE3NTA0MjAzODcuMTEyNzQ0LCJuYmYiOjE3NTA0MjAzODcuMTEyNzQ3LCJleHAiOjE3ODE5NTYzODcuMTA0NTA2LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.dtknLHwt96etJGhnnBVRC-5wl276ONK_0rUKgYOPFFyQCqSyVlFWfPK2h1iLSw7pkII3Vc36iC2IMTDWaAxZilB9kYMcpRwuA4ybWpBzvU-95bILholwgFjSK1AzjHvGiPjK7g9DCq6no-Fp3vT7_intMLRm8TQ-EL12X1F-nF6Q1d7zST4xXuLlEA4W8kb3JvXpFx4FYdL4RIfhjW7E5p-sD7VoI6rOYZSlesfBbBV-EEJM03CL1ic7pkmiM9tQAFnaQ2r8xpyLNRn7FqVgg6JnY2lciHl8Y6kcxDf0Z98af1HajDqeNAeqV1c-CKg-wCcx8cn5cx7UXjA021BuRQGAazeluYKQywLdOWJc-4PBBbKY69klZ4NN8trJAYNHItbBVLQ41L6mcX0ywm_LK1JWPeawjW4Y0UZFiawVeWz8QYojduUi98XnLr34cnzxSabi1pv6D20BqRGtmlFuPS6IgWop6JHpwICauF3hgnmgnaArGx5WoQsUcYChdm7Eoh5kQyGfH2tmUUrHeCtiF4Ef1-7gCOW43lo7CBb9D41KNHvDZe2ynyERPlaF-kBYVEmOD4D7BEiGa4xE67uf_BYghAej-rqnR4BRKgk8COX1K38vjbwv_BV5Q-iyFKtRYIPcMTvOVPw2liq4X0B1P_wXzFMHj0VCXZGchC1e57Y"
        
        let gateway = DriverStatisticsUseCase()
        let result = try? await gateway.fetchStatistics(type: "daily")
        
        print("result: ", result?.allBonus)
        XCTAssertNotNil(result)
        
    }
}

