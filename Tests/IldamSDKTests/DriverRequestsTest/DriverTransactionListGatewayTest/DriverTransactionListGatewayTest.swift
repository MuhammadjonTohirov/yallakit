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
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiNjY4MTNhYTdmM2JjZjQxN2I4NmM5Njc0N2EzNDE1MWE0MzgwNzNmY2NkNjU5ZTcwNzNiYzg0NDc1YTMzOTc1NTAxY2VkODBhOGNhZmUzNDUiLCJpYXQiOjE3NTA0MTEwNjYuNzY3MzI1LCJuYmYiOjE3NTA0MTEwNjYuNzY3MzI3LCJleHAiOjE3ODE5NDcwNjYuNzYzOTc4LCJzdWIiOiI1NTIiLCJzY29wZXMiOlsiZXhlY3V0b3IiXX0.6MfTSlEKktmrP0T-pCrAzGeEhi2VmUjvBLUG5SYxHxNHm8-L96d0DiPSG1t4VoubPBUL8wxHfWeX80X77Z_S1NTzQX53mp1iKl4p69DBbg-7MDgGAZ29BVf_-A1vkGyGibxnQa5NCXsXK1mQwIz4FV-T0qYhqHW3KxcJ31FR9SNClqViY5e3uX_3m9yL-ilQZAB0ckuWYvTdY35zukSMLcpBsG8rqTWiE27VdQTZ_PBXPj2pOu2fqMABVGpcuOuC0Z0Ou7YYFgmdUBzZ-58svV0aMte5ObGWYhu2zEQqV8e-VlHtBdQ2lICc8lG3f-9ZVVfSRq8zrf3alRKJV1tdpOT6WoBoaH0li9_SZoYLM_Uen6jQausTeabXxd4FkaF8gZtdtUfvtt9y9QRqFSypHwbqXnM_Q-zIS1ZKuromaBUvxasq4O76BvgK0Gh-GSClzJJATCgqGqOcHEmv0IXtJPbyG9q_kTCfVTViQRHgrZkoicUfwg_Gi2XMzio7F-NX2MI8Fs3uznvgIjgmjA4Sp6WPmFh79mAt9VB3OHnvp_VYqNsJL_xm8-ykwEy6cFTZdQr3R4BkLHMaODUxCe8CYxOPqkkf3SuAFaOnwYPIQ8e3TwovEiYIew-eEjksOXOhar2TMT3NsQWK_6C-ra_R1_fEPx42c6zml1Qai0HRNWc"
        
        let gateway = DriverTransactionUseCase()
        
        let result = try? await gateway.fetchTransactions(type: "all")
        print("result: ", result?.balance ?? 0)
        XCTAssertNotNil(result)
    }
}


