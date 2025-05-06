//
//  SendDriverPhotoFontrollerTest.swift
//  YallaKit
//
//  Created by MuhammadAli on 01/05/25.
//

@testable import IldamSDK
@testable import NetworkLayer
@testable import Core
import XCTest
@testable import IldamDriverSDK

final class SendDriverPhotoFontrollerTest: XCTestCase {
    func testExecute_getPolygonList() async {
 
        let getway = SendFotoControlGateway()
        
        let res = try? await getway.sendPhotos(body: [
            SendFotoControlBodyItem(type: "car", photoControlId: 2, file: "441669701831.png"),
            SendFotoControlBodyItem(type: "car", photoControlId: 3, file: "441669701831.png"),
            SendFotoControlBodyItem(type: "car", photoControlId: 4, file: "441669701831.png"),
            SendFotoControlBodyItem(type: "document", photoControlId: 5, file: "441669701831.png"),
            SendFotoControlBodyItem(type: "document", photoControlId: 6, file: "441669701831.png")
            ]
        )
        
        XCTAssertNotNil(res)
    }
}
