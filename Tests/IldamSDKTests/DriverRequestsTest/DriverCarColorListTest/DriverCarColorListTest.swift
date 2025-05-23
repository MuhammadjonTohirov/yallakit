//
//  DriverCarColorList.swift
//  YallaKit
//
//  Created by MuhammadAli on 02/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverCarColorList: XCTestCase {
    func test_fetchColor() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiNGNjMjdjMTA3NjI4YzMwZjI0OGY1ZGMwNmY2YTdkMGNhMzhkZmNjOTc5ZTU5OTViMzcxNTQ4OGNiOTExN2MwMjgwNTJlY2MzNDNmN2ZiNDIiLCJpYXQiOjE3NDczOTg4MzYuOTUzNjUzLCJuYmYiOjE3NDczOTg4MzYuOTUzNjU0LCJleHAiOjE3Nzg5MzQ4MzYuOTQ1NTc1LCJzdWIiOiIxMjQ3OSIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.are2ql5KVbv5mtlBTTS9r7C7Gjtj7ckwT6Hiu59Cp4ujcKT77TxjSJw4qWOfsRb2jcoGSLG_h1EervqGEDonV0ZQ7_V1cffsriBouYLTu_bAKwvtKTE_FOBaO_YdUS-UW7uo9G0-XYKxezXdSrvg-LZ_cyNNh6mUhRzReANLeVxXjwh-CF4wSEhKwRArzJkQCFKhTHkDnDyVsRmWmkB7LmIVc5h4Pr05PbE5Dnk_-LDWwoFjrEm4U5wPEdq8MbTIe56HNCBfWWqnlVF7mJwufsmF5v3xN_KtOcjlCkt1PltOmJUPH813sARJ5dWKvT7SuUGKyM9G3aKXVOSY_psbaWkjOqK7ywhhe944THGeTAvQ2wY7qm9tP9GE07NYQz5rf1s2vLYy2xhZfY_QBSKH5lLiPdGdoqPHb6jws3Qlco-YCEjkVRM-hbJzQQCwQaXRh5nt1S4Ybvj3W1B88ljZl-YkbdW5wzrXjCQ3o8AStyYcyqe_XMaSb7NdLD_tfLOVEmF2MPhVEowtohIdGToHh3ivaFBv8BhA5VZnzbYho4oGv5xTU57m-iA2CXvmste7MmS-CalEADG_quY7wgbFJqR_tvETfdMfTCl-vOxcUg2mhQjCJssCRtbHhyFL6HVWvRV__duuy2xJruUvBHFjP2xgnUp09U9hlBXnzWoFB78"
        
        let gateway = DriverCarColorListGateway()
        let result = try? await gateway.fetchColors()
        XCTAssertNotNil(result)
        
    }
}
