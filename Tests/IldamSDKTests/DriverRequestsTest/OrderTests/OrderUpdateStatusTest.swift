//
//  OrderUpdateStatus .swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//

import XCTest
@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
@testable import IldamDriverSDK

final class OrderUpdateStatusTest : XCTestCase {
    func test_OrderUpdateTest() async {
        
        let gateway = OrderStatusUpdateGetway()
        let result = try? await gateway.orderUpdate(orderId: 1962622)
        
        XCTAssertNotNil(result)
        
    }
}
