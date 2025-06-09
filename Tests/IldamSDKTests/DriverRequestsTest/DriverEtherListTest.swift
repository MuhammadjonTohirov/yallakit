//
//  DriverEtherListTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 28/04/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class DriverEtherListTest: XCTestCase {
    func testExecute_getorderList() async {

        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiYjRlM2VkMDU5YmJiNDMyM2FjZmE0YzgzZDk5OWQ0YTlhNDMwNWI3MWIwMThmNDZhOWJhYTgzMTI0ZDg0MzhlNjYxNjA4NjE4MDAwNmNjODciLCJpYXQiOjE3NDk0NDc0MjIuMTIwOTksIm5iZiI6MTc0OTQ0NzQyMi4xMjA5OTIsImV4cCI6MTc4MDk4MzQyMi4xMTY2NDUsInN1YiI6IjU1MiIsInNjb3BlcyI6WyJleGVjdXRvciJdfQ.kkwUmrbSnEY7raLa2uzF_gzwrOM7z1uHwr13s6Bu2qjgAn7NoRRhYIJcJX0PzSuwX-fxkKUizgPu_T5Nrstuyuk5x8jLmlOxuCYjklRVRXkWLorXR7pnStgimYlsZ6UXgnE1CdVNT4U-93UGSpGye9mouYpGRfMrIgQh8xB3GSIb1mvDFrffmUYK3y4YmFb1Oi4Q9O7b_fXpaA31PnOxHtqMRVL5ChFAJ7HlHkpT0q5qrAwwxMXM-dRWEQwfkwbfrcC45_clvJb-mKF0s3RlTyCL26Z3WOY1OOd-5wcuhA-sWAGmh5VbP25YwwlWAA7PINEn0vsCUDFFCo32bsmItY28HhdbpQr9wYDIlYYYBz4gGkxaPkRfUJWluWTZ_ZM6zFjSsDCLpGUmzGemIEm-4s49a6Kzu77iEALDVYP9QN33lShrWzGDZwTvunYTKAP9DGfU7wJeq0kUfkmNsBMQz1rMJLVmYcN0Cmoem35CodirujR1Z4vrW7-7Jvk0fC3K09io_oPcZJviXpGVHqux7AJvtXFcrA0rWuOHFXSkpMcujJEG7PKY6xdbRnp8xTlPbMubJu_D7bpMPaEkVeaLcu9y7ysAPv_QdLchD07C936O8HliD8zTnF8zWrfm3oZYzEQiK4JYez_qOlJiJBG6F1UoystxwEmbl1RQihWTsPg"
        
        let getway = OrderListUseCase()
        
        let res = try? await getway.fetchOrderList(type: "ether")
        print("res: ", res?.list[0].id ?? 0)
        XCTAssertNotNil(res)

    }
}
