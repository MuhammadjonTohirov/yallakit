//
//  DriverSendCoordTets.swift
//  YallaKit
//
//  Created by MuhammadAli on 30/04/25.
//

import XCTest
@testable import IldamDriverSDK
@testable import NetworkLayer
@testable import Core

final class DriverSendCoordTest: XCTestCase {
    func test_sendOnline() async {
        
        let gateway = DriverSendCoordGateway()

        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiYjRlM2VkMDU5YmJiNDMyM2FjZmE0YzgzZDk5OWQ0YTlhNDMwNWI3MWIwMThmNDZhOWJhYTgzMTI0ZDg0MzhlNjYxNjA4NjE4MDAwNmNjODciLCJpYXQiOjE3NDk0NDc0MjIuMTIwOTksIm5iZiI6MTc0OTQ0NzQyMi4xMjA5OTIsImV4cCI6MTc4MDk4MzQyMi4xMTY2NDUsInN1YiI6IjU1MiIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.kkwUmrbSnEY7raLa2uzF_gzwrOM7z1uHwr13s6Bu2qjgAn7NoRRhYIJcJX0PzSuwX-fxkKUizgPu_T5Nrstuyuk5x8jLmlOxuCYjklRVRXkWLorXR7pnStgimYlsZ6UXgnE1CdVNT4U-93UGSpGye9mouYpGRfMrIgQh8xB3GSIb1mvDFrffmUYK3y4YmFb1Oi4Q9O7b_fXpaA31PnOxHtqMRVL5ChFAJ7HlHkpT0q5qrAwwxMXM-dRWEQwfkwbfrcC45_clvJb-mKF0s3RlTyCL26Z3WOY1OOd-5wcuhA-sWAGmh5VbP25YwwlWAA7PINEn0vsCUDFFCo32bsmItY28HhdbpQr9wYDIlYYYBz4gGkxaPkRfUJWluWTZ_ZM6zFjSsDCLpGUmzGemIEm-4s49a6Kzu77iEALDVYP9QN33lShrWzGDZwTvunYTKAP9DGfU7wJeq0kUfkmNsBMQz1rMJLVmYcN0Cmoem35CodirujR1Z4vrW7-7Jvk0fC3K09io_oPcZJviXpGVHqux7AJvtXFcrA0rWuOHFXSkpMcujJEG7PKY6xdbRnp8xTlPbMubJu_D7bpMPaEkVeaLcu9y7ysAPv_QdLchD07C936O8HliD8zTnF8zWrfm3oZYzEQiK4JYez_qOlJiJBG6F1UoystxwEmbl1RQihWTsPg"
        
        let result = try? await gateway.sendCoordsWithoutOrder(lat: 0, lng: 0, heading: 0, speed: 0)
        
//        let resultOrder = try? await gateway.sendCoordsWithOrder(
//            body: SendCoordsBody(
//            coords: SendCoords(
//                heading: 360,
//                lat: 40.383702,
//                lng: 71.783059,
//                speed: 50,
//                orderStatus: "in_fetters",
//                orderId: nil,
//                online: true,
//                statusTime: "123231"
//            ),
//            orderCheck: OrderCheck(
//                coverPrice: 500,
//                accountCalculationStatus: false,
//                distance: 1.13,
//                duration: "0.29",
//                fullDistance: "2.09",
//                fullDuration: "6.8066",
//                inCity: DNetLocationZone(
//                    distance: 1.13,
//                    duration: "0.29",
//                    waitPrice: 2891.4666666666662,
//                    waitTime: "5.78"
//                ),
//                isWaitingTime: true,
//                outCity: DNetLocationZone(
//                    distance: 0.0,
//                    duration: "0.00",
//                    waitPrice: 0.0,
//                    waitTime: "0.00"
//                ),
//                remainderPrice: -151,
//                startPrice: 0,
//                totalMinutePrice: 0,
//                totalPrice: 5000,
//                tripPrice: 2260,
//                waitPrice: 2891,
//                waitTime: "5.78"
//            )
//        ))
        
        XCTAssertNotNil(result)
                                                   
    }
}
