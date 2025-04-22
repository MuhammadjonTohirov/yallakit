//
//  File.swift
//  YallaKit
//
//  Created by Muhammadjon Tohirov on 22/04/25.
//

import XCTest
@testable import IldamSDK
@testable import NetworkLayer
@testable import Core

final class LoadNotificationsUseCaseTests: XCTestCase {
    
    // MARK: - Mocks
    
    class MockLoadNotificationsGateway: LoadNotificationsGatewayProtocol {
        var mockResult: NetResNotifications?
        var shouldThrow = false
        
        func load(page: Int, perPage: Int) async throws -> NetResNotifications? {
            if shouldThrow {
                throw NSError(domain: "TestError", code: -1)
            }
            return mockResult
        }
    }
    
    func prepareForTest() {
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMzM0NTllNWJhMzYxNjBlYjAyZTc4MGMwZDkwMWI0OTM0YTExMzJkZjA2ZWZkMzJmNWYyZjQ1MmRmOGIyMmI2MTlkYjMzZDIzYTU2ZmQyNTkiLCJpYXQiOjE3NDQ4NzU4ODUuOTE0ODI5LCJuYmYiOjE3NDQ4NzU4ODUuOTE0ODMxLCJleHAiOjE3NzY0MTE4ODUuOTA4NTgsInN1YiI6IjI0MjAzNSIsInNjb3BlcyI6WyJjbGllbnQiXX0.eTkG-iZYxU0tCZGsZS6VD4NlUeTRP4bYKfwrQv_YLiQJ0ma_9y5pgDaZ4yr0QX2P_GyiVMnyYAeVSc18sE3rfpeQbJfXe50L3rry9YSWza-ZhQFKodD0WtJ4aUqwOvQjLVeYOQUb0YFgfY2nCrGZqX5q2IiX7Coq9injWHz_l47FpPKhWsc8vtcbhF9O4u3CiB9sIMX6k5yrNxhGF3p93073Kf3A-zOZg-ADX5rsktR22eaHbJXCgp-xfMkX94m7fm55TmhO7YGoreyoSg9TwBWEZD-FJGPVcFDnnJ2w7BA6X0QmrSzhhgIk00flDLrT1-IyHoResBdoDMIcvYMYF2S0whoJEZbNxLM38Ju5_VuVyj6dVvIuw2I3J2EtkE7vmtRLXn_XY7YYp0FsvvKNws3Zo_zsyQFEf28jzxNQT8nPq3NsLbSyBqNp-1KGn_3f6zKLhQ2vztQNEJp_tmCvEVa-t7K1o-E-_U70Trqj2Fzo9Z-kGOqWqyt_9I2nbPob1HVy2PngMLLUPeo3joRD4YHyMSatZAgey_E5o6b6w_nH3eFXekQtja1176_bXj1aBqsL7LuDUtyt_np9faPM9zcvs6wMhC1FYshW47OD0qJaS9EO5SzwKpwc7HTTd4OmTvv-cI6aJEdjBnZBWrZ3KBchvL7ws9ZxZ2h_lgkYeFA"
    }
    
    func testExecute_WithExactResponseFromExample_ReturnsCorrectResult() async throws {
        // Arrange
        let mockGateway = MockLoadNotificationsGateway()
        let useCase = LoadNotificationsUseCase(gateway: mockGateway)
        
        // Use the exact JSON response provided in the requirements
        let fullJson = """
        {
            "success": true,
            "code": 200,
            "result": {
                "list": [],
                "pagination": {
                    "total": 0,
                    "count": 0,
                    "per_page": 25,
                    "current_page": 1,
                    "total_pages": 1,
                    "last_page": 1
                }
            },
            "message": ""
        }
        """
        
        let jsonData = fullJson.data(using: .utf8)!
        let netRes = try JSONDecoder().decode(NetRes<NetResNotifications>.self, from: jsonData)
        mockGateway.mockResult = netRes.result
        
        // Act
        let result = try await useCase.execute(page: 1, perPage: 25)
        
        // Assert
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertEqual(result?.list?.count, 0, "Should have empty list")
    }
    
    func testExecute_WhenNilResponse_ReturnsNil() async throws {
        // Arrange
        let mockGateway = MockLoadNotificationsGateway()
        mockGateway.mockResult = nil
        let useCase = LoadNotificationsUseCase(gateway: mockGateway)
        
        // Act
        let result = try await useCase.execute(page: 1, perPage: 25)
        
        // Assert
        XCTAssertNil(result, "Result should be nil when gateway returns nil")
    }
    
    func testExecute_WhenBodyNotNil() async throws {
        prepareForTest()
        
        let usecase = LoadNotificationsUseCase()
        
        let result = try await usecase.execute(page: 1, perPage: 25)
        
        XCTAssertNotNil(result)
    }
}
