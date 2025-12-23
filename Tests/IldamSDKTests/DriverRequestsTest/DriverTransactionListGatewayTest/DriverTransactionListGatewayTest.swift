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
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiN2IwOWM4ZTZhMDc4MTQ2N2ZhMjAzM2E1MTFlZGEzN2M2MzU4MTkyZmMwNzBjNmUwZGM1Y2E3MjFiNDJmZjJlODhjMDljMzZmOTQ2NzlkZDIiLCJpYXQiOjE3NjU5NzAxNDcuNDk1NDk5LCJuYmYiOjE3NjU5NzAxNDcuNDk1NTAxLCJleHAiOjE3OTc1MDYxNDcuNDkxMjE0LCJzdWIiOiI1OTk4Iiwic2NvcGVzIjpbImNsaWVudCJdfQ.nfoWYDFA16VQj-9LlKuzzcJXCQB89D6PoilbYzb8PsiUvdK8kyvhAn-JkZ0jk2GkgIuVVuEDlaqh22skP_BO-cCD-Mj8OjECPB1tOfozzMUqOXA1z71oNy80MnqeRrrb_W38ddIX8s91bAPNIvSVy-X8Yjhw2Whe__xOt1zakyTt9pTqkhdsggTJycK8WBESj6SqzrCQh8GYZ_Tr6aElyk0KxyiVw79nDFW_CU5y871XjaM0D8ss_WHjiQhWmDLuTpJMgAhuhTFcYrUeLr5Mf6824gdmtIbPleWnojSN8hyApHJuLtpljelDJI-BtgqC_8C5sfCTAsI0QDPsbBysEnQW53TjwJAETb-mRleYAXunUfxOiurwT7vriiKTOlAXiufvq6XSg6YQVf8tyDOjX-uum1Zc2zc5s72OQpERkMGdmPJkZU033p36_b7NMb47ZAcSHbQguGfnm_s8DFICz5L5Aldy9R3SOB7C44O0ANf3XxgglhQV-jGOX1VXiMRB7gqlrp8J8EgTONk-oAvDN1MlSM8nKysJXWxbRsq5-dXqK7M6r3CLXrlxq-tf5GVhJ72gU_xVdaMhvUB4Il6-I9ndR9ClRrmU5R7TmXf4UZzTKiHRdjRt93_LtsqrDbYHbw2jWjZzKb_v895zEp-EwvntGddxd1MKd_G7Zj_Pfmg"
        
        let gateway = FetchSecondaryAddressesUseCase()
        
        let result = try? await gateway.fetch(lat: 40.378157, lng: 71.777169)
        print("result: ", result?.balance ?? 0)
        XCTAssertNotNil(result)
    }
}


