//
//  ExecutorTariffGatewayTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 06/05/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class ExecutorTariffGatewayTest: XCTestCase {
    func test_fetchTariff() async {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiYWU4MmRiNTQxNjcyMTlmNjc4YTcyNTkyNjZmYzM0OTk0NzY1MWYzMWY2NjYyMzM0MTNiMGRhMzgzZTEyOTlhZjgxNzI3YzhkMTU1ZjdmYjQiLCJpYXQiOjE3NDkwNDM1MjcuMjUwODcxLCJuYmYiOjE3NDkwNDM1MjcuMjUwODc0LCJleHAiOjE3ODA1Nzk1MjcuMjQ3MjA2LCJzdWIiOiIxODEwMyIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.1Z0D-e6TPLKl0SRKNtwkXv1KftjLaEYUrvoLL-znZqRwOnny0tRphPTeMI9z9J9CfAJkjkP5q6rBGNxgFtlrdAgN0D2meDR7daJwoTheB5chlSMqZo47WKSpWIiW_gN2XYX_cAAEmhlQi45kbF_2rFUAcG5xc0naX59nwQiy4NXcPdcvDXMRUVEstf9SmU0IYHOwWcAJxO_hLKgugO20ZCEUZJb3ag-rJehaOZEzIOF5piK4vxF1xBWmIK8x6xJfmYVq_RL9RDeIOVKGjxAIpCa5G8FAaWShpJZ6TJntxRUA0CbC-Qse21Eel1pwdagDuND2RZ0QX_H4PjUukuTjH0Y9bm4zaUP6jul4I9fQWAhK_Jo1RiQS2d6hObCyDUw_D5wBIQNRFk9salF9fUczkRc03QLdeIel_1QXVRmI5r1GD01w13d6zxQ1NvdL5LjgkI_6OrGfqt1G_6zKijPR8uhfISI03xO_Az9DNuy8-kiCeczbV4dLbUwDABkIBGpHOto232jnUooQt02kSDifH1Wg0B-X6HRCIGRMwiN6ks3yOhZzmLaa31aSgTz5z5dNVtyQHRLVOsvKbq1JdlgCEcRwBDTkNBgKsONoCk-zg6wlaepg6G6LC7P0fE1pUgJODoO8CECdc6WIS6SUbs_AhTF1SOb1d9dL9P3hK15kjDw"
        
        let gateway = ExecutorTariffGateway()
        let result = try? await gateway.fetchExecutorTariffs()
        print("result: ", result)
        XCTAssertNotNil(result)
        
    }
}

