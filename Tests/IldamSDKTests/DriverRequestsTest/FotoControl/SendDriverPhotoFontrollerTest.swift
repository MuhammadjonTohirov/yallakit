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
        UserSettings.shared.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiNmMwNjI5Zjc0YjVjNTkwYmU4MDE0NjUzNDM3ZWM1YmY3MmIyZTllMTgwODlmZDBlNjY0MDhkZjU2MWFiMGU0ODY2YzEzNWJiYTczMmQ0OWQiLCJpYXQiOjE3NDY1MTMzNjQuNzg4NTE4LCJuYmYiOjE3NDY1MTMzNjQuNzg4NTIsImV4cCI6MTc3ODA0OTM2NC43ODIyNzgsInN1YiI6IjEyNDc5Iiwic2NvcGVzIjpbImV4ZWN1dG9yIl19.MElaGMmL2t1c6pFLqsUFqehTCdj4LUGjs6u-W6xHwMiolySXHX7bS97xIIb1SM_VekLj-ORipWcNdvFSeD5X516sNE_WtDrGVZ_s0S4iQl8cvz0I_P4nZOQiV_d9P5gMi_eq7B00JZyo8JORYfWt0jkjFycKmzvUjqdiTZppdWIIgs9cuFi_E4eKqVCy7L9WuXi7rQagrcLXrgTLR-WZJJiu51g-eCTkF2GffYtn0HugMPfEaiICvcPdr-DIsZZz3Fhugw74LT9OEoN8riGoB8rnOERYPGQc1qg-Qgg1xwWE9UaX0k_vUiVgykjAjl5tBmOxU4QACwQy2Y_j2bw5BmjpbpGOm9O0SDHpc5aeT_uS7tzL-3R7u_mjOBFSP72cPVb0Eyo1kMOWDZwMeIpsnnMjjQ768NNp_3vASbghxXSQRz2SUkZ4uH69h9BB8C_rj2RmdC2TN5dFyIAWH24Qi14V2heaPiSYU-ifteI8nnBgju2kPP7S7s-oWuc8ew7CO-bs5S9AmkTr7KJCYHrJDh-haILcIM9dHvVqplLxJeNXLem3-sUdcu03AS-0szwAj1xFm9ubptc1K96fQzikqjNRm3sxGYA0X0S6b5Nj-5zN5lQsYibTZcNuIp6YRR4HekelKXTTyzeQ2pHbw99X-YsG8hxVeDiJcB1paQoH-tM"

        let getway = SendFotoControlGateway()
        
        let res = try? await getway.sendPhotos(body: [
            SendFotoControlBodyItem(type: "car", photoControlId: 2, file: "12323131321.png"),
//            SendFotoControlBodyItem(type: "car", photoControlId: 3, file: "441669701831.png"),
//            SendFotoControlBodyItem(type: "car", photoControlId: 4, file: "441669701831.png"),
//            SendFotoControlBodyItem(type: "document", photoControlId: 5, file: "441669701831.png"),
//            SendFotoControlBodyItem(type: "document", photoControlId: 6, file: "441669701831.png")
            ]
        )
        
        XCTAssertNotNil(res)
    }
}
